#
# prp-osg-pool/provisioner
#
# BSD license, copyright Igor Sfiligoi 2021
#
# Implement the Kubernetes interface
#

import copy
import re
import kubernetes
import time

from prp_provisioner.provisioner_k8s import ProvisionerK8S


class OSGProvisionerK8S(ProvisionerK8S):
   """Kubernetes Query interface"""

   def __init__(self, namespace, cvmfs_mounts,
                condor_host="osg-collector.default.svc.cluster.local",
                k8s_image='sfiligoi/prp-portal-wn:gke_nosing',
                k8s_image_pull_policy='Always',
                priority_class = None,
                base_tolerations = ['osglimit'],
                additional_labels = {},
                additional_envs = [],
                additional_volumes = {},
                additional_tolerations = [],
                additional_node_selectors = {}):
      """
      Arguments:
         namespace: string
             Monitored namespace
         cvmfs_mount: list of strings
             CVMFS mounts needed by the pods
         condor_host: string (Optional)
             DNS address of the HTCOndor collector
         k8s_image: string (Optional)
             WN Container image to use in the pod
         k8s_image_pull_policy: string (Optional)
             WN Container image pull policy
         priority_class: string (Optional)
             priorityClassName to associate with the pod
         base_tolerations: list of strings (Optional)
             Tolerations of the form NoSchedule/Exists to add to the container
         additional_labels: dictionary of strings (Optional)
             Labels to attach to the pod
         additional_envs: list of (name,value) pairs (Optional)
             Environment values to add to the container
         additional_volumes: dictionary of (volume,mount) pairs (Optional)
             Volumes to mount in the pod. Both volume and mount must be a dictionary.
         additional_tolerations: list of dictionaries (Optional)
             Tolerations to add to the container
         additional_node_selectors: dictionary of strings (Optional)
             nodeSelectors to attach to the pod
      """
      ProvisionerK8S.__init__(self, namespace,
                              condor_host, k8s_image, k8s_image_pull_policy, priority_class, base_tolerations,
                              additional_labels, additional_envs, additional_volumes,
                              additional_tolerations, additional_node_selectors)
      self.cvmfs_mounts = cvmfs_mounts
      # we will use a slightly different app-name for easier monitoring
      self.app_name = 'osg-wn'


   # INTERNAL

   def _augment_labels(self, labels, attrs):
      """Add any additional labels to the dictionary (attrs is read-only)"""
      labels['osg-provisioner'] = 'wn'
      return

   def _augment_environment(self, env_list, attrs):
      """Add any additional (name,value) pairs to the list (attrs is read-only)"""
      return

   def _augment_volumes(self, volumes, attrs):
      """Add any additional (volume,mount) pair to the dictionary (attrs is read-only)"""

      # mount the shared secret
      # instead of the token
      volumes['configpasswd'] = \
                   (
                      {
                         'secret': {
                            'secretName': 'osg-pool-config',
                            'defaultMode': 256,
                            'items': [{
                               'key': 'pool_password',
                               'path': 'pool_password'
                            }]
                         }
                      },
                      {
                         'mountPath': '/etc/condor/secret/pool_password',
                         'subPath': 'pool_password',
                         'readOnly': True
                      }
                   )

      # we always need the osg-config, oasis 
      for c in (['config-osg','oasis'] + self.cvmfs_mounts):
         ext='opensciencegrid.org' if c!='stash' else 'osgstorage.org'
         volumes["cvmfs-%s"%c] = \
                   (
                      {
                         'persistentVolumeClaim': {
                            'claimName': "cvmfs-%s"%c
                         }
                      },
                      {
                         'mountPath': "/cvmfs/%s.%s"%(c,ext),
                         'readOnly': True
                      }
                   )

      return

   def _augment_node_selectors(self, node_selectors, attrs):
      """Add any additional elements to the dictionary (attrs is read-only)"""
      return


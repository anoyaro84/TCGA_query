
import synapseclient
import synapseutils

syn = synapseclient.Synapse()
syn.login('yo.kim','as4251')
files = synapseutils.syncFromSynapse(syn, 'syn2812961', 'data')



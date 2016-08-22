import { withPluginApi } from 'discourse/lib/plugin-api';

export default {
  name: 'apply-embedFB',
  initialize() {
    withPluginApi('0.1', api => {
      api.decorateCooked($elem => $('.embedFB', $elem).embedFB());
    });
  }
};

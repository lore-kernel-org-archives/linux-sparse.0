From: Shannon Nelson <snelson@pensando.io>
Subject: smatch/sparse complaints on static assertion
Date: Tue, 11 Feb 2020 09:41:05 -0800
Message-ID: <ecdd10cb-0022-8f8a-ec36-9d51b3ae85ee@pensando.io>
References: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pl1-f172.google.com ([209.85.214.172]:37775 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgBKRlH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 11 Feb 2020 12:41:07 -0500
Received: by mail-pl1-f172.google.com with SMTP id c23so4548040plz.4
        for <linux-sparse@vger.kernel.org>; Tue, 11 Feb 2020 09:41:07 -0800 (PST)
In-Reply-To: <e588417e-1bf4-35e3-d8d9-9911fe29e0f5@pensando.io>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@oracle.com>

Hi All,

I'm getting complaints from smatch on the ionic network driver's static 
assertions and am not sure why it was complaining.  Dan Carpenter 
suggested this might be an issue in sparse with how it is calculating 
the sizes of the unions.

I ran this at the top of a pretty recent net-next tree 
(v5.5-rc7-1839-g8192c36)
$ ../smatch/smatch_scripts/kchecker drivers/net/ethernet/pensando/ionic/

And got several copies of this:

drivers/net/ethernet/pensando/ionic/ionic_dev.h:38:1: error: static 
assertion failed: "sizeof(union ionic_dev_regs) == 4096"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:40:1: error: static 
assertion failed: "sizeof(union ionic_dev_cmd_regs) == 2048"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:56:1: error: static 
assertion failed: "sizeof(struct ionic_dev_getattr_comp) == 16"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:57:1: error: static 
assertion failed: "sizeof(struct ionic_dev_setattr_cmd) == 64"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:58:1: error: static 
assertion failed: "sizeof(struct ionic_dev_setattr_comp) == 16"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:68:1: error: static 
assertion failed: "sizeof(struct ionic_port_getattr_comp) == 16"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:78:1: error: static 
assertion failed: "sizeof(struct ionic_lif_getattr_comp) == 16"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:79:1: error: static 
assertion failed: "sizeof(struct ionic_lif_setattr_cmd) == 64"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:80:1: error: static 
assertion failed: "sizeof(struct ionic_lif_setattr_comp) == 16"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:82:1: error: static 
assertion failed: "sizeof(struct ionic_q_init_cmd) == 64"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:117:1: error: static 
assertion failed: "sizeof(struct ionic_vf_setattr_cmd) == 64"
drivers/net/ethernet/pensando/ionic/ionic_dev.h:120:1: error: static 
assertion failed: "sizeof(struct ionic_vf_getattr_comp) == 16"

These static assertion lines have been fine up until now and I'm pretty 
sure they are correct.

Has this issue been seen elsewhere?  Or is there something I can do in 
our code to get rid of the complaints?

Thanks,
sln

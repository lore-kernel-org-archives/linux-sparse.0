Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9DDC4727E
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3928A20706
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0FQHFG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730118AbgJATlZ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATlY (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 15:41:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13150C0613D0
        for <linux-sparse@vger.kernel.org>; Thu,  1 Oct 2020 12:41:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so65297wrv.1
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=19/le1TZfxV4XGsVEW8w7ab6Q7IyKQZLIlX2P4Duf+E=;
        b=a0FQHFG0HcEs8bAOvPoVV6MeV67QjsHlI0BbVweyR51DT2RFuRxaYLgmvqBXRJbNQM
         3QX/A7uOn5vtX4bO83CxOvdqdNUF1ryth35aMx4gIGcTa7/MbaQgrJ6/bgD5zRcMpWHd
         ZKW4PyNocwWB0HFN0ie8ASyEXhyFqSQpQmvpKeC9MrhW4phuIZhfLxZ5Bejg1wnvzh3h
         I6VEFoeoeahI0qR9nUbQX9mKxOoxHvhpmNF8bMcXgRI9GQRWqVR8puer38wO1SfoUzo9
         DsuoYtG4Fw8j7yQkVOl9A2gx/6pgKN/4/HJYEfS0D99zmbMjI9H8nAS7y0VcoYiMi/8V
         65Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=19/le1TZfxV4XGsVEW8w7ab6Q7IyKQZLIlX2P4Duf+E=;
        b=pBKLhdGPJbaBAE9mo1H462nmAMNOQrt9dDjSD8WAZCFEz+U9G+0BS44r5y4FMGn0Sz
         6/Q3uMPLJ1QOYUcz4iFAMzaI4+Y6ZhLw6ElP31QEhsGMKVF8TKbpDJK6XSiWfotj+A2p
         /fOnOOCX/bDM8m7R78Lwx08uWIggByIx+a5dRdGLzrbq2gKhl6s6SDP33hn1jD1Haol8
         5gpdrPJDaIMXJF0OmVg9E55AtUGtvC4Ylbsp8q2ikQbIupcl7EzCi+B8lrDN28mCwOTy
         EK0rFjp3gCQmcfB4jdFbsRjOGre/SJJb7ri0kHSPn4jvLMK+3znUcC1LrbI8hF7oQ5eF
         qb0w==
X-Gm-Message-State: AOAM5324R0bZdEol9ceeHXvDQFQYnaUyOEZmEnoG3SE9aB7vQgWznKKj
        yok5eRq92sX1NqgNdIamTx76JZQVunE=
X-Google-Smtp-Source: ABdhPJx3dOpfggQN8LKv1soVMmk8fEGTs8zaFthqLDLKw3m77Y000h0lsLGhND2iLy2+WC6YCoN49Q==
X-Received: by 2002:adf:cd0e:: with SMTP id w14mr11767834wrm.0.1601581282728;
        Thu, 01 Oct 2020 12:41:22 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:853c:f0a7:910c:921f])
        by smtp.gmail.com with ESMTPSA id u66sm6752790wme.1.2020.10.01.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:41:21 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:41:21 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 13/13] flex-array: warn when a flexible array member has
 some padding
Message-ID: <20201001194121.2lk6e66zycgtoqkw@ltop.local>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
 <20200930231828.66751-14-luc.vanoostenryck@gmail.com>
 <CAHk-=wiyAWuHQuDPBC290V-Bx5Eyu1izPj9iSSN0hdkSM2a4iQ@mail.gmail.com>
 <20201001191706.nefotol6m2oqrtcg@ltop.local>
 <CAHk-=wh7LNGQ5aDtJeRzkLPUewUjgoc3eiKF_Yh81kfU-XPHCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5nbwgbmmt77zv6lj"
Content-Disposition: inline
In-Reply-To: <CAHk-=wh7LNGQ5aDtJeRzkLPUewUjgoc3eiKF_Yh81kfU-XPHCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org


--5nbwgbmmt77zv6lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 01, 2020 at 12:27:56PM -0700, Linus Torvalds wrote:
> On Thu, Oct 1, 2020 at 12:17 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > > So in the kernel, we would
> > >
> > >  - start warning about 'sizeof(flex_struct)'
> >
> > Adding this warning by default annoys me slightly because it will
> > add 5700+ warnings to the 18000 already present and I think sparse
> > is already underused because it is very/too noisy. But I guess that
> > most occurrences come from a few macros and thus should be easy to
> > get rid off.
> 
> Hopefully. I'll try to take a look. Do you have the sparse changes in
> a git branch already so that I can just try that directly?

What I posted yesterday is on
	git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git flex-array

> Or if you send me a couple of examples, maybe it's just the same
> pattern over and over,..

Well, the 888 occurences I see are already 'unique' occurences
(in the sense that the warning is from a distinct file+position).
I'm adding in attachment the extract of my test logs (but it is
on v5.9-rc1 so it's maybe not much usefull). I ddn't investigated
anything, just checked a few case to see that it was a genuine
occurrence.

-- Luc

--5nbwgbmmt77zv6lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nested-flex-array.txt"

    268 ./include/net/ip.h:44:8: warning: nested flexible arrays
    228 ./include/linux/tty.h:85:8: warning: nested flexible arrays
    228 ./include/linux/tty.h:230:8: warning: nested flexible arrays
    219 ./include/crypto/hash.h:231:8: warning: nested flexible arrays
    141 ./include/linux/ieee80211.h:1119:39: warning: nested flexible arrays
    141 ./include/linux/ieee80211.h:1103:31: warning: nested flexible arrays
    141 ./include/linux/ieee80211.h:1101:24: warning: nested flexible arrays
    141 ./include/linux/ieee80211.h:1047:15: warning: nested flexible arrays
    141 ./include/linux/ieee80211.h:1040:8: warning: nested flexible arrays
    134 ./include/crypto/skcipher.h:37:8: warning: nested flexible arrays
    129 net/mac80211/ieee80211_i.h:871:8: warning: nested flexible arrays
    121 net/mac80211/sta_info.h:535:8: warning: nested flexible arrays
    102 ./include/crypto/aead.h:152:8: warning: nested flexible arrays
    100 fs/ocfs2/ocfs2_fs.h:725:15: warning: nested flexible arrays
     88 drivers/net/wireless/marvell/mwifiex/fw.h:2309:15: warning: nested flexible arrays
     74 ./include/crypto/hash.h:216:8: warning: nested flexible arrays
     63 ./include/net/inet_sock.h:58:8: warning: nested flexible arrays
     61 ./include/linux/serial_core.h:285:8: warning: nested flexible arrays
     59 net/wireless/core.h:24:8: warning: nested flexible arrays
     56 drivers/md/bcache/bcache.h:507:8: warning: nested flexible arrays
     56 ./include/linux/console_struct.h:94:8: warning: nested flexible arrays
     55 ./include/net/tcp.h:872:23: warning: nested flexible arrays
     55 ./include/net/tcp.h:859:15: warning: nested flexible arrays
     55 ./include/net/tcp.h:825:8: warning: nested flexible arrays
     51 ./include/linux/usb/serial.h:72:8: warning: nested flexible arrays
     47 ./include/net/flow_offload.h:377:8: warning: nested flexible arrays
     46 ./include/crypto/skcipher.h:43:8: warning: nested flexible arrays
     44 ./include/net/xfrm.h:589:15: warning: nested flexible arrays
     44 ./include/net/xfrm.h:588:8: warning: nested flexible arrays
     42 drivers/md/bcache/bcache.h:231:8: warning: nested flexible arrays
     39 ./include/linux/crypto.h:639:8: warning: nested flexible arrays
     37 net/mac80211/key.h:59:8: warning: nested flexible arrays
     36 fs/ext4/ext4.h:2188:16: warning: nested flexible arrays
     36 ./include/rdma/ib_verbs.h:2055:7: warning: nested flexible arrays
     36 ./include/crypto/internal/aead.h:21:24: warning: nested flexible arrays
     36 ./include/crypto/internal/aead.h:20:15: warning: nested flexible arrays
     36 ./include/crypto/internal/aead.h:18:8: warning: nested flexible arrays
     35 arch/x86/events/intel/../perf_event.h:199:8: warning: nested flexible arrays
     34 net/wireless/core.h:150:8: warning: nested flexible arrays
     30 net/mac80211/ieee80211_i.h:836:8: warning: nested flexible arrays
     26 drivers/net/wireless/ath/ath10k/htt.h:1811:15: warning: nested flexible arrays
     26 ./include/net/xfrm.h:661:8: warning: nested flexible arrays
     26 ./include/net/sctp/structs.h:1548:8: warning: nested flexible arrays
     26 ./include/linux/sctp.h:275:8: warning: nested flexible arrays
     24 net/mac80211/ieee80211_i.h:797:8: warning: nested flexible arrays
     24 drivers/md/bcache/journal.h:128:8: warning: nested flexible arrays
     24 drivers/md/bcache/bcache.h:407:8: warning: nested flexible arrays
     24 ./include/net/mac80211.h:2572:8: warning: nested flexible arrays
     24 ./include/linux/hyperv.h:725:8: warning: nested flexible arrays
     24 ./include/linux/hyperv.h:685:8: warning: nested flexible arrays
     24 ./include/linux/errqueue.h:15:15: warning: nested flexible arrays
     24 ./include/linux/errqueue.h:14:8: warning: nested flexible arrays
     24 ./include/linux/cgroup-defs.h:494:8: warning: nested flexible arrays
     24 ./include/acpi/actypes.h:1156:8: warning: nested flexible arrays
     23 ./include/crypto/internal/skcipher.h:22:24: warning: nested flexible arrays
     23 ./include/crypto/internal/skcipher.h:21:15: warning: nested flexible arrays
     23 ./include/crypto/internal/skcipher.h:19:8: warning: nested flexible arrays
     22 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h:219:8: warning: nested flexible arrays
     21 ./include/crypto/rng.h:54:8: warning: nested flexible arrays
     21 ./include/crypto/akcipher.h:48:8: warning: nested flexible arrays
     20 fs/ocfs2/ocfs2_fs.h:662:8: warning: nested flexible arrays
     20 ./include/net/xfrm.h:607:8: warning: nested flexible arrays
     20 ./include/net/inet_sock.h:63:8: warning: nested flexible arrays
     19 security/apparmor/include/policy.h:129:8: warning: nested flexible arrays
     19 ./include/net/xfrm.h:629:8: warning: nested flexible arrays
     18 ./include/crypto/internal/hash.h:46:24: warning: nested flexible arrays
     18 ./include/crypto/internal/hash.h:45:15: warning: nested flexible arrays
     18 ./include/crypto/internal/hash.h:43:8: warning: nested flexible arrays
     16 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h:235:15: warning: nested flexible arrays
     16 drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_utils.h:232:17: warning: nested flexible arrays
     16 drivers/net/ethernet/aquantia/atlantic/aq_hw.h:173:8: warning: nested flexible arrays
     16 drivers/md/bcache/bcache.h:298:8: warning: nested flexible arrays
     16 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/dbg-tlv.h:219:8: warning: nested flexible arrays
     15 ./include/crypto/kpp.h:42:8: warning: nested flexible arrays
     14 fs/dlm/dlm_internal.h:518:8: warning: nested flexible arrays
     14 drivers/md/bcache/journal.h:119:9: warning: nested flexible arrays
     14 drivers/md/bcache/journal.h:104:8: warning: nested flexible arrays
     14 drivers/md/bcache/bcache.h:675:9: warning: nested flexible arrays
     14 drivers/md/bcache/bcache.h:227:9: warning: nested flexible arrays
     14 drivers/md/bcache/bcache.h:225:8: warning: nested flexible arrays
     14 ./include/linux/pci.h:297:8: warning: nested flexible arrays
     13 ./include/crypto/internal/scompress.h:15:8: warning: nested flexible arrays
     12 ./include/net/udp.h:40:15: warning: nested flexible arrays
     12 ./include/net/udp.h:39:8: warning: nested flexible arrays
     12 ./include/linux/jbd2.h:1603:16: warning: nested flexible arrays
     11 drivers/nvme/target/nvmet.h:323:24: warning: nested flexible arrays
     11 drivers/nvme/target/nvmet.h:322:15: warning: nested flexible arrays
     11 drivers/nvme/target/nvmet.h:313:8: warning: nested flexible arrays
     11 drivers/net/wireless/marvell/mwifiex/fw.h:2304:8: warning: nested flexible arrays
     11 drivers/net/wireless/marvell/mwifiex/fw.h:1149:8: warning: nested flexible arrays
     11 ./drivers/net/wireless/intel/iwlwifi/dvm/..//fw/api/dbg-tlv.h:219:8: warning: nested flexible arrays
     10 sound/usb/caiaq/device.h:60:8: warning: nested flexible arrays
     10 drivers/net/wireless/ath/carl9170/fwcmd.h:230:15: warning: nested flexible arrays
     10 drivers/net/wireless/ath/carl9170/fwcmd.h:228:8: warning: nested flexible arrays
     10 drivers/net/wireless/ath/carl9170/carl9170.h:375:15: warning: nested flexible arrays
     10 drivers/net/wireless/ath/carl9170/carl9170.h:233:8: warning: nested flexible arrays
     10 drivers/md/bcache/bset.h:157:8: warning: nested flexible arrays
     10 ./include/sound/intel-nhlt.h:66:8: warning: nested flexible arrays
     10 ./include/pcmcia/cistpl.h:533:15: warning: nested flexible arrays
      9 drivers/md/bcache/btree.h:122:9: warning: nested flexible arrays
      9 drivers/md/bcache/btree.h:117:8: warning: nested flexible arrays
      9 ./include/linux/crypto.h:643:8: warning: nested flexible arrays
      9 ./include/crypto/acompress.h:47:8: warning: nested flexible arrays
      8 net/dccp/dccp.h:339:15: warning: nested flexible arrays
      8 net/dccp/dccp.h:338:8: warning: nested flexible arrays
      8 fs/ocfs2/ocfs2_fs.h:968:15: warning: nested flexible arrays
      8 fs/ocfs2/ocfs2_fs.h:898:24: warning: nested flexible arrays
      8 fs/ocfs2/ocfs2_fs.h:896:15: warning: nested flexible arrays
      8 fs/ocfs2/ocfs2_fs.h:878:8: warning: nested flexible arrays
      8 drivers/scsi/hisi_sas/hisi_sas.h:565:15: warning: nested flexible arrays
      8 drivers/net/wireless/intel/iwlegacy/common.h:549:8: warning: nested flexible arrays
      8 drivers/net/wireless/intel/iwlegacy/commands.h:3335:8: warning: nested flexible arrays
      8 drivers/net/wireless/intel/iwlegacy/commands.h:1195:8: warning: nested flexible arrays
      8 drivers/md/dm-rq.h:27:8: warning: nested flexible arrays
      8 drivers/md/bcache/bcache.h:738:8: warning: nested flexible arrays
      8 drivers/infiniband/hw/i40iw/i40iw_cm.h:354:15: warning: nested flexible arrays
      8 crypto/gcm.c:71:15: warning: nested flexible arrays
      8 crypto/ccm.c:46:15: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:2020:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:2007:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1992:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1978:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1963:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1949:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1931:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1906:8: warning: nested flexible arrays
      8 ./include/rdma/ib_verbs.h:1892:8: warning: nested flexible arrays
      8 ./include/net/cfg80211.h:2830:8: warning: nested flexible arrays
      8 ./include/crypto/internal/akcipher.h:16:24: warning: nested flexible arrays
      8 ./include/crypto/internal/akcipher.h:15:15: warning: nested flexible arrays
      8 ./include/crypto/internal/akcipher.h:13:8: warning: nested flexible arrays
      7 fs/btrfs/volumes.h:289:8: warning: nested flexible arrays
      7 drivers/net/wireless/ti/wl1251/acx.h:16:8: warning: nested flexible arrays
      7 drivers/clk/samsung/clk.h:22:8: warning: nested flexible arrays
      7 ./include/linux/mlx5/mlx5_ifc.h:3363:8: warning: nested flexible arrays
      6 fs/ocfs2/ocfs2_fs.h:844:15: warning: nested flexible arrays
      6 fs/ocfs2/ocfs2_fs.h:505:8: warning: nested flexible arrays
      6 fs/ocfs2/ocfs2_fs.h:1083:15: warning: nested flexible arrays
      6 fs/cifs/cifsglob.h:135:8: warning: nested flexible arrays
      6 drivers/scsi/aic94xx/aic94xx_sas.h:574:15: warning: nested flexible arrays
      6 drivers/scsi/aic94xx/aic94xx_sas.h:572:8: warning: nested flexible arrays
      6 drivers/scsi/aic94xx/aic94xx_sas.h:319:8: warning: nested flexible arrays
      6 drivers/net/wireless/wl3501.h:382:8: warning: nested flexible arrays
      6 drivers/net/wireless/wl3501.h:309:8: warning: nested flexible arrays
      6 drivers/net/wireless/ti/wlcore/acx.h:54:8: warning: nested flexible arrays
      6 drivers/md/raid5.h:249:16: warning: nested flexible arrays
      6 ./include/uapi/linux/bcache.h:345:8: warning: nested flexible arrays
      6 ./include/linux/mlx5/mlx5_ifc.h:7681:8: warning: nested flexible arrays
      6 ./include/linux/mlx5/mlx5_ifc.h:3265:8: warning: nested flexible arrays
      6 ./include/linux/ceph/osdmap.h:144:15: warning: nested flexible arrays
      6 ./include/crypto/if_alg.h:109:15: warning: nested flexible arrays
      5 drivers/scsi/qla2xxx/qla_dbg.h:301:15: warning: nested flexible arrays
      5 drivers/scsi/qla2xxx/qla_dbg.h:276:8: warning: nested flexible arrays
      5 drivers/scsi/isci/request.h:82:8: warning: nested flexible arrays
      5 drivers/scsi/isci/request.h:137:31: warning: nested flexible arrays
      5 drivers/scsi/isci/request.h:132:24: warning: nested flexible arrays
      5 drivers/scsi/isci/request.h:131:15: warning: nested flexible arrays
      5 drivers/net/wireless/wl3501.h:439:8: warning: nested flexible arrays
      5 drivers/net/wireless/ti/wl1251/acx.h:149:8: warning: nested flexible arrays
      5 drivers/net/wireless/microchip/wilc1000/spi.c:52:15: warning: nested flexible arrays
      5 arch/x86/events/zhaoxin/../perf_event.h:199:8: warning: nested flexible arrays
      5 arch/x86/events/perf_event.h:199:8: warning: nested flexible arrays
      5 arch/x86/events/intel/../perf_event.h:794:24: warning: nested flexible arrays
      5 arch/x86/events/intel/../perf_event.h:792:15: warning: nested flexible arrays
      5 arch/x86/events/intel/../perf_event.h:789:8: warning: nested flexible arrays
      5 arch/x86/events/amd/../perf_event.h:199:8: warning: nested flexible arrays
      5 ./include/linux/mlx5/mlx5_ifc.h:7705:8: warning: nested flexible arrays
      5 ./include/linux/mlx5/mlx5_ifc.h:7627:8: warning: nested flexible arrays
      5 ./include/linux/iomap.h:191:8: warning: nested flexible arrays
      5 ./include/linux/ecryptfs.h:93:8: warning: nested flexible arrays
      5 ./include/linux/ecryptfs.h:100:15: warning: nested flexible arrays
      5 ./include/linux/ceph/ceph_fs.h:508:8: warning: nested flexible arrays
      5 ./include/crypto/internal/hash.h:35:24: warning: nested flexible arrays
      5 ./include/crypto/internal/hash.h:34:15: warning: nested flexible arrays
      5 ./include/crypto/internal/hash.h:32:8: warning: nested flexible arrays
      5 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/scan.h:827:15: warning: nested flexible arrays
      4 sound/core/vmaster.c:47:8: warning: nested flexible arrays
      4 net/xfrm/xfrm_input.c:32:15: warning: nested flexible arrays
      4 net/xfrm/xfrm_input.c:31:8: warning: nested flexible arrays
      4 net/ipv6/esp6.c:42:8: warning: nested flexible arrays
      4 net/ipv6/ah6.c:42:8: warning: nested flexible arrays
      4 net/ipv4/inet_fragment.c:36:15: warning: nested flexible arrays
      4 net/ipv4/inet_fragment.c:35:8: warning: nested flexible arrays
      4 net/ipv4/icmp.c:100:8: warning: nested flexible arrays
      4 net/ieee802154/core.h:7:8: warning: nested flexible arrays
      4 kernel/trace/trace_uprobe.c:55:8: warning: nested flexible arrays
      4 kernel/trace/trace_kprobe.c:55:8: warning: nested flexible arrays
      4 kernel/bpf/core.c:1857:15: warning: nested flexible arrays
      4 kernel/bpf/core.c:1843:15: warning: nested flexible arrays
      4 fs/squashfs/squashfs_fs.h:395:7: warning: nested flexible arrays
      4 fs/ocfs2/ocfs2_fs.h:942:8: warning: nested flexible arrays
      4 fs/notify/fdinfo.c:43:16: warning: nested flexible arrays
      4 fs/nfs_common/nfsacl.c:43:8: warning: nested flexible arrays
      4 fs/ext4/mballoc.c:2407:16: warning: nested flexible arrays
      4 fs/dlm/dlm_internal.h:455:7: warning: nested flexible arrays
      4 fs/block_dev.c:264:8: warning: nested flexible arrays
      4 drivers/scsi/hisi_sas/hisi_sas.h:587:8: warning: nested flexible arrays
      4 drivers/scsi/hisi_sas/hisi_sas.h:576:7: warning: nested flexible arrays
      4 drivers/scsi/hisi_sas/hisi_sas.h:566:24: warning: nested flexible arrays
      4 drivers/scsi/hisi_sas/hisi_sas.h:563:8: warning: nested flexible arrays
      4 drivers/pcmcia/pcmcia_cis.c:138:8: warning: nested flexible arrays
      4 drivers/net/wireless/ti/wlcore/acx.h:474:8: warning: nested flexible arrays
      4 drivers/net/wireless/intel/iwlegacy/common.h:551:15: warning: nested flexible arrays
      4 drivers/net/wireless/intel/iwlegacy/commands.h:3348:15: warning: nested flexible arrays
      4 drivers/net/ethernet/sfc/vfdi.h:167:15: warning: nested flexible arrays
      4 drivers/net/ethernet/aquantia/atlantic/hw_atl/../hw_atl/hw_atl_utils.h:235:15: warning: nested flexible arrays
      4 drivers/net/ethernet/aquantia/atlantic/hw_atl/../hw_atl/hw_atl_utils.h:232:17: warning: nested flexible arrays
      4 drivers/net/ethernet/aquantia/atlantic/hw_atl/../aq_hw.h:173:8: warning: nested flexible arrays
      4 drivers/md/dm.c:95:8: warning: nested flexible arrays
      4 drivers/md/dm.c:80:8: warning: nested flexible arrays
      4 drivers/md/bcache/bcache.h:740:15: warning: nested flexible arrays
      4 drivers/infiniband/hw/i40iw/i40iw_cm.h:315:8: warning: nested flexible arrays
      4 drivers/infiniband/hw/cxgb4/t4.h:98:7: warning: nested flexible arrays
      4 drivers/gpu/drm/amd/amdgpu/si_dpm.h:799:8: warning: nested flexible arrays
      4 drivers/firmware/efi/libstub/file.c:32:8: warning: nested flexible arrays
      4 drivers/firmware/efi/libstub/efi-stub-helper.c:428:21: warning: nested flexible arrays
      4 crypto/rsa-pkcs1pad.c:100:8: warning: nested flexible arrays
      4 crypto/gcm.c:98:16: warning: nested flexible arrays
      4 crypto/gcm.c:63:8: warning: nested flexible arrays
      4 crypto/gcm.c:53:8: warning: nested flexible arrays
      4 crypto/gcm.c:37:8: warning: nested flexible arrays
      4 crypto/drbg.c:1669:8: warning: nested flexible arrays
      4 crypto/ctr.c:22:8: warning: nested flexible arrays
      4 crypto/ccm.c:39:8: warning: nested flexible arrays
      4 crypto/ccm.c:33:8: warning: nested flexible arrays
      4 crypto/asymmetric_keys/restrict.c:19:15: warning: nested flexible arrays
      4 ./include/scsi/fc_encode.h:27:15: warning: nested flexible arrays
      4 ./include/net/sctp/structs.h:1117:15: warning: nested flexible arrays
      4 ./include/net/sctp/structs.h:1116:8: warning: nested flexible arrays
      4 ./include/net/nsh.h:213:15: warning: nested flexible arrays
      4 ./include/net/nsh.h:208:8: warning: nested flexible arrays
      4 ./include/linux/sctp.h:724:8: warning: nested flexible arrays
      4 ./include/linux/mlx5/mlx5_ifc.h:6331:8: warning: nested flexible arrays
      4 ./include/linux/mlx5/mlx5_ifc.h:6224:8: warning: nested flexible arrays
      3 sound/usb/6fire/comm.h:19:8: warning: nested flexible arrays
      3 net/netfilter/x_tables.c:796:8: warning: nested flexible arrays
      3 net/netfilter/x_tables.c:791:8: warning: nested flexible arrays
      3 fs/overlayfs/overlayfs.h:102:15: warning: nested flexible arrays
      3 fs/overlayfs/overlayfs.h:100:8: warning: nested flexible arrays
      3 fs/ocfs2/ocfs2_fs.h:815:8: warning: nested flexible arrays
      3 fs/ocfs2/ocfs2_fs.h:1066:8: warning: nested flexible arrays
      3 fs/ocfs2/ocfs2_fs.h:1046:8: warning: nested flexible arrays
      3 fs/ocfs2/ocfs2_fs.h:1033:8: warning: nested flexible arrays
      3 fs/f2fs/f2fs.h:1701:16: warning: nested flexible arrays
      3 drivers/tty/hvc/hvc_console.h:35:8: warning: nested flexible arrays
      3 drivers/staging/wlan-ng/hfa384x.h:1229:8: warning: nested flexible arrays
      3 drivers/staging/rtl8192u/ieee80211/ieee80211.h:977:8: warning: nested flexible arrays
      3 drivers/nvdimm/nd.h:163:8: warning: nested flexible arrays
      3 drivers/net/wireless/ti/wl18xx/../wlcore/acx.h:54:8: warning: nested flexible arrays
      3 drivers/net/wireless/ti/wl12xx/../wlcore/acx.h:54:8: warning: nested flexible arrays
      3 drivers/net/wireless/ath/ath10k/htt.h:1793:15: warning: nested flexible arrays
      3 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h:664:15: warning: nested flexible arrays
      3 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:646:8: warning: nested flexible arrays
      3 drivers/infiniband/hw/cxgb4/t4.h:113:7: warning: nested flexible arrays
      3 drivers/gpu/drm/nouveau/nvif/notify.c:169:16: warning: nested flexible arrays
      3 drivers/gpu/drm/nouveau/nouveau_svm.c:73:8: warning: nested flexible arrays
      3 drivers/crypto/ccp/ccp-crypto.h:112:8: warning: nested flexible arrays
      3 drivers/clk/x86/clk-cgu.h:79:8: warning: nested flexible arrays
      3 ./include/uapi/linux/bcache.h:355:9: warning: nested flexible arrays
      3 ./include/uapi/linux/bcache.h:354:9: warning: nested flexible arrays
      3 ./include/scsi/scsi_bsg_iscsi.h:69:15: warning: nested flexible arrays
      3 ./include/scsi/scsi_bsg_iscsi.h:67:8: warning: nested flexible arrays
      3 ./include/linux/sctp.h:664:8: warning: nested flexible arrays
      3 ./include/linux/sctp.h:227:8: warning: nested flexible arrays
      3 ./include/linux/mlx5/mlx5_ifc.h:6297:8: warning: nested flexible arrays
      3 ./include/linux/mlx5/mlx5_ifc.h:4789:8: warning: nested flexible arrays
      3 ./include/linux/mlx5/mlx5_ifc.h:4227:8: warning: nested flexible arrays
      3 ./include/crypto/if_alg.h:95:8: warning: nested flexible arrays
      2 sound/usb/6fire/midi.h:15:8: warning: nested flexible arrays
      2 security/integrity/evm/evm.h:46:8: warning: nested flexible arrays
      2 net/nfc/hci/hci.h:21:8: warning: nested flexible arrays
      2 net/netfilter/nft_set_pipapo.h:175:8: warning: nested flexible arrays
      2 net/dccp/ccids/lib/../../dccp.h:339:15: warning: nested flexible arrays
      2 net/dccp/ccids/lib/../../dccp.h:338:8: warning: nested flexible arrays
      2 net/dccp/ccids/../dccp.h:339:15: warning: nested flexible arrays
      2 net/dccp/ccids/../dccp.h:338:8: warning: nested flexible arrays
      2 fs/xfs/xfs_rmap_item.h:46:8: warning: nested flexible arrays
      2 fs/xfs/xfs_refcount_item.h:45:8: warning: nested flexible arrays
      2 fs/xfs/xfs_log_priv.h:195:16: warning: nested flexible arrays
      2 fs/xfs/xfs_bmap_item.h:43:8: warning: nested flexible arrays
      2 fs/ocfs2/ocfs2_fs.h:858:8: warning: nested flexible arrays
      2 fs/notify/fanotify/fanotify.h:169:8: warning: nested flexible arrays
      2 fs/notify/fanotify/fanotify.h:155:8: warning: nested flexible arrays
      2 fs/ecryptfs/ecryptfs_kernel.h:364:8: warning: nested flexible arrays
      2 fs/cifs/smb2inode.c:50:8: warning: nested flexible arrays
      2 drivers/staging/rtl8192u/ieee80211/ieee80211.h:1008:8: warning: nested flexible arrays
      2 drivers/staging/rtl8192e/rtllib.h:824:8: warning: nested flexible arrays
      2 drivers/scsi/isci/task.h:88:15: warning: nested flexible arrays
      2 drivers/scsi/isci/task.h:84:8: warning: nested flexible arrays
      2 drivers/scsi/hisi_sas/hisi_sas.h:593:8: warning: nested flexible arrays
      2 drivers/net/wireless/wl3501.h:575:8: warning: nested flexible arrays
      2 drivers/net/wireless/ti/wlcore/wl12xx_80211.h:109:8: warning: nested flexible arrays
      2 drivers/net/wireless/ti/wl18xx/acx.h:266:8: warning: nested flexible arrays
      2 drivers/net/wireless/ti/wl12xx/acx.h:241:8: warning: nested flexible arrays
      2 drivers/net/wireless/ti/wl1251/wl12xx_80211.h:120:8: warning: nested flexible arrays
      2 drivers/net/wireless/ti/wl1251/acx.h:1060:8: warning: nested flexible arrays
      2 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1645:8: warning: nested flexible arrays
      2 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1569:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlwifi/mvm/sta.h:351:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h:246:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h:203:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h:178:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlegacy/commands.h:2662:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlegacy/3945.h:126:15: warning: nested flexible arrays
      2 drivers/net/wireless/intel/iwlegacy/3945.h:125:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/ipw2x00/libipw.h:477:8: warning: nested flexible arrays
      2 drivers/net/wireless/intel/ipw2x00/libipw.h:448:8: warning: nested flexible arrays
      2 drivers/net/wireless/ath/ath10k/htt.h:1809:8: warning: nested flexible arrays
      2 drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls.h:59:8: warning: nested flexible arrays
      2 drivers/media/platform/xilinx/xilinx-dma.h:73:8: warning: nested flexible arrays
      2 drivers/md/bcache/request.h:5:8: warning: nested flexible arrays
      2 drivers/md/bcache/request.h:33:9: warning: nested flexible arrays
      2 drivers/md/bcache/request.c:463:8: warning: nested flexible arrays
      2 drivers/md/bcache/movinggc.c:15:8: warning: nested flexible arrays
      2 drivers/md/bcache/journal.h:83:8: warning: nested flexible arrays
      2 drivers/infiniband/sw/rdmavt/mr.h:53:8: warning: nested flexible arrays
      2 drivers/infiniband/hw/mlx5/fs.c:1058:23: warning: nested flexible arrays
      2 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:611:15: warning: nested flexible arrays
      2 drivers/infiniband/hw/cxgb4/t4fw_ri_api.h:598:8: warning: nested flexible arrays
      2 drivers/infiniband/hw/cxgb4/t4.h:392:8: warning: nested flexible arrays
      2 drivers/infiniband/core/uverbs_ioctl.c:43:8: warning: nested flexible arrays
      2 drivers/gpu/drm/nouveau/nvif/object.c:61:16: warning: nested flexible arrays
      2 drivers/gpu/drm/nouveau/nvif/object.c:266:16: warning: nested flexible arrays
      2 drivers/gpu/drm/nouveau/nvif/object.c:185:16: warning: nested flexible arrays
      2 drivers/gpu/drm/nouveau/nvif/object.c:142:16: warning: nested flexible arrays
      2 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h:293:7: warning: nested flexible arrays
      2 drivers/crypto/qce/cipher.h:34:8: warning: nested flexible arrays
      2 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h:151:8: warning: nested flexible arrays
      2 drivers/block/rnbd/rnbd-srv-dev.h:22:8: warning: nested flexible arrays
      2 crypto/chacha20poly1305.c:64:15: warning: nested flexible arrays
      2 crypto/adiantum.c:101:15: warning: nested flexible arrays
      2 ./include/sound/intel-nhlt.h:56:8: warning: nested flexible arrays
      2 ./include/scsi/fc_encode.h:25:8: warning: nested flexible arrays
      2 ./include/net/sctp/structs.h:334:8: warning: nested flexible arrays
      2 ./include/net/nfc/nci.h:518:8: warning: nested flexible arrays
      2 ./include/linux/sctp.h:390:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:7729:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:7494:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:6414:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:6367:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:5680:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:3863:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:3403:8: warning: nested flexible arrays
      2 ./include/linux/mlx5/mlx5_ifc.h:10373:8: warning: nested flexible arrays
      2 ./include/linux/hyperv.h:1055:8: warning: nested flexible arrays
      2 ./include/linux/efi.h:923:15: warning: nested flexible arrays
      2 ./include/linux/efi.h:922:8: warning: nested flexible arrays
      2 ./include/linux/ceph/osdmap.h:140:8: warning: nested flexible arrays
      2 ./include/crypto/cryptd.h:52:8: warning: nested flexible arrays
      2 ./include/crypto/cryptd.h:33:8: warning: nested flexible arrays
      2 ./include/crypto/cryptd.h:21:8: warning: nested flexible arrays
      2 ./include/asm-generic/hyperv-tlfs.h:403:8: warning: nested flexible arrays
      2 ./include/asm-generic/hyperv-tlfs.h:352:8: warning: nested flexible arrays
      2 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/dbg.h:83:8: warning: nested flexible arrays
      1 sound/usb/misc/ua101.c:112:24: warning: nested flexible arrays
      1 sound/usb/hiface/pcm.c:24:8: warning: nested flexible arrays
      1 sound/usb/6fire/pcm.h:24:8: warning: nested flexible arrays
      1 sound/soc/intel/skylake/skl-i2s.h:80:8: warning: nested flexible arrays
      1 security/keys/trusted-keys/trusted_tpm1.c:37:8: warning: nested flexible arrays
      1 security/keys/dh.c:82:8: warning: nested flexible arrays
      1 security/integrity/ima/ima_template_lib.c:269:16: warning: nested flexible arrays
      1 security/integrity/ima/ima_main.c:752:16: warning: nested flexible arrays
      1 security/integrity/ima/ima_init.c:50:16: warning: nested flexible arrays
      1 security/integrity/ima/ima_api.c:220:16: warning: nested flexible arrays
      1 security/integrity/evm/../integrity.h:89:8: warning: nested flexible arrays
      1 net/sched/sch_taprio.c:84:8: warning: nested flexible arrays
      1 net/sched/sch_atm.c:64:8: warning: nested flexible arrays
      1 net/rxrpc/key.c:968:16: warning: nested flexible arrays
      1 net/nfc/nci/hci.c:53:8: warning: nested flexible arrays
      1 net/netfilter/nft_set_rbtree.c:25:8: warning: nested flexible arrays
      1 net/netfilter/nft_set_hash.c:417:8: warning: nested flexible arrays
      1 net/netfilter/nft_set_hash.c:29:8: warning: nested flexible arrays
      1 net/netfilter/nft_set_bitmap.c:15:8: warning: nested flexible arrays
      1 net/ipv4/esp4.c:26:8: warning: nested flexible arrays
      1 net/ipv4/ah4.c:18:8: warning: nested flexible arrays
      1 net/core/bpf_sk_storage.c:67:8: warning: nested flexible arrays
      1 net/ceph/auth_x_protocol.h:63:8: warning: nested flexible arrays
      1 net/bluetooth/rfcomm/tty.c:46:8: warning: nested flexible arrays
      1 net/bluetooth/mgmt_config.c:29:16: warning: nested flexible arrays
      1 net/bluetooth/l2cap_core.c:7985:16: warning: nested flexible arrays
      1 net/bluetooth/l2cap_core.c:5915:16: warning: nested flexible arrays
      1 net/bluetooth/l2cap_core.c:3930:16: warning: nested flexible arrays
      1 net/bluetooth/l2cap_core.c:1383:16: warning: nested flexible arrays
      1 net/bluetooth/l2cap_core.c:1382:8: warning: nested flexible arrays
      1 lib/crc-t10dif.c:65:16: warning: nested flexible arrays
      1 lib/bch.c:112:8: warning: nested flexible arrays
      1 kernel/events/core.c:7809:8: warning: nested flexible arrays
      1 kernel/bpf/bpf_struct_ops.c:29:8: warning: nested flexible arrays
      1 fs/ubifs/commit.c:497:8: warning: nested flexible arrays
      1 fs/ocfs2/xattr.c:53:8: warning: nested flexible arrays
      1 fs/jffs2/summary.h:140:7: warning: nested flexible arrays
      1 fs/dlm/user.c:58:16: warning: nested flexible arrays
      1 fs/dlm/user.c:52:8: warning: nested flexible arrays
      1 fs/dlm/requestqueue.c:18:8: warning: nested flexible arrays
      1 fs/dlm/midcomms.c:59:15: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:899:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:894:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:886:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:878:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:864:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:847:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:830:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:818:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:811:8: warning: nested flexible arrays
      1 fs/cifs/smb2pdu.h:805:8: warning: nested flexible arrays
      1 fs/btrfs/send.c:44:15: warning: nested flexible arrays
      1 fs/btrfs/send.c:43:8: warning: nested flexible arrays
      1 drivers/w1/w1_netlink.c:216:16: warning: nested flexible arrays
      1 drivers/w1/w1_netlink.c:195:16: warning: nested flexible arrays
      1 drivers/usb/host/xhci-dbgcap.h:100:8: warning: nested flexible arrays
      1 drivers/usb/host/oxu210hp-hcd.c:396:8: warning: nested flexible arrays
      1 drivers/usb/host/ehci-fsl.c:419:8: warning: nested flexible arrays
      1 drivers/usb/gadget/function/uvc_configfs.c:858:8: warning: nested flexible arrays
      1 drivers/usb/gadget/function/u_serial.c:98:8: warning: nested flexible arrays
      1 drivers/usb/class/cdc-acm.h:83:8: warning: nested flexible arrays
      1 drivers/tty/synclinkmp.c:151:16: warning: nested flexible arrays
      1 drivers/tty/synclink_gt.c:238:8: warning: nested flexible arrays
      1 drivers/tty/synclink.c:178:8: warning: nested flexible arrays
      1 drivers/tty/serial/kgdb_nmi.c:90:8: warning: nested flexible arrays
      1 drivers/tty/serial/ifx6x60.h:56:8: warning: nested flexible arrays
      1 drivers/tty/rocket_int.h:1127:8: warning: nested flexible arrays
      1 drivers/tty/nozomi.c:318:8: warning: nested flexible arrays
      1 drivers/tty/n_gsm.c:125:8: warning: nested flexible arrays
      1 drivers/tty/mxser.c:220:8: warning: nested flexible arrays
      1 drivers/tty/moxa.c:129:8: warning: nested flexible arrays
      1 drivers/tty/isicom.c:198:9: warning: nested flexible arrays
      1 drivers/tty/ipwireless/tty.c:46:8: warning: nested flexible arrays
      1 drivers/tty/goldfish.c:36:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192u/ieee80211/ieee80211.h:991:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192u/ieee80211/ieee80211.h:971:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192u/ieee80211/ieee80211.h:966:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192u/ieee80211/ieee80211.h:957:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:846:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:838:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:818:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:813:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:808:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtllib.h:799:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtl8192e/../rtllib.h:846:8: warning: nested flexible arrays
      1 drivers/staging/rtl8192e/rtl8192e/../rtllib.h:824:8: warning: nested flexible arrays
      1 drivers/staging/ks7010/ks_hostif.h:211:8: warning: nested flexible arrays
      1 drivers/staging/greybus/uart.c:43:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:99:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:95:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:90:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:84:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:78:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:71:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:129:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:125:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:121:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:117:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:112:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:108:8: warning: nested flexible arrays
      1 drivers/staging/greybus/audio_apbridgea.h:104:8: warning: nested flexible arrays
      1 drivers/staging/gdm724x/gdm_tty.h:25:8: warning: nested flexible arrays
      1 drivers/staging/fwserial/fwserial.h:238:8: warning: nested flexible arrays
      1 drivers/staging/comedi/drivers/jr3_pci.c:93:7: warning: nested flexible arrays
      1 drivers/scsi/qla2xxx/qla_tmpl.h:76:24: warning: nested flexible arrays
      1 drivers/scsi/qla2xxx/qla_tmpl.h:66:17: warning: nested flexible arrays
      1 drivers/scsi/pmcraid.h:658:8: warning: nested flexible arrays
      1 drivers/scsi/pmcraid.h:630:8: warning: nested flexible arrays
      1 drivers/scsi/pm8001/pm80xx_hwi.h:556:8: warning: nested flexible arrays
      1 drivers/scsi/pm8001/pm8001_hwi.h:337:8: warning: nested flexible arrays
      1 drivers/scsi/ipr.h:1465:8: warning: nested flexible arrays
      1 drivers/rpmsg/qcom_glink_native.c:911:16: warning: nested flexible arrays
      1 drivers/rpmsg/qcom_glink_native.c:790:16: warning: nested flexible arrays
      1 drivers/rpmsg/qcom_glink_native.c:48:8: warning: nested flexible arrays
      1 drivers/rpmsg/qcom_glink_native.c:408:16: warning: nested flexible arrays
      1 drivers/rpmsg/qcom_glink_native.c:1266:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:948:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:451:8: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:3237:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:2294:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:1930:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:1370:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:1117:16: warning: nested flexible arrays
      1 drivers/pci/controller/pci-hyperv.c:1028:16: warning: nested flexible arrays
      1 drivers/nvme/target/tcp.c:93:8: warning: nested flexible arrays
      1 drivers/nvme/target/tcp.c:55:8: warning: nested flexible arrays
      1 drivers/nvme/target/rdma.c:56:8: warning: nested flexible arrays
      1 drivers/nvme/target/loop.c:29:8: warning: nested flexible arrays
      1 drivers/nvme/target/loop.c:18:8: warning: nested flexible arrays
      1 drivers/nvme/target/fc.c:70:8: warning: nested flexible arrays
      1 drivers/nfc/pn533/usb.c:259:8: warning: nested flexible arrays
      1 drivers/nfc/pn533/usb.c:252:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:426:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:266:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:258:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:253:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:248:8: warning: nested flexible arrays
      1 drivers/net/wireless/wl3501.h:237:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/wl12xx_80211.h:133:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/scan.h:125:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:696:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:685:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:681:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:677:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:656:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:647:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:634:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:599:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:583:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:563:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:554:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:539:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:464:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:431:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:395:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:386:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:378:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:288:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:265:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:257:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/cmd.h:217:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:944:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:930:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:919:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:901:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:878:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:822:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:810:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:801:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:788:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:773:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:760:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:741:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:718:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:689:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:664:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:644:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:629:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:584:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:566:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:558:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:546:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:529:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:518:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:458:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:452:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:446:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:434:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:424:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:417:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:402:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:385:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:369:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:360:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:352:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:343:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:327:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:312:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:303:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:295:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:287:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:280:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:271:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:262:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:213:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:205:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:195:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:185:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:172:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:153:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wlcore/acx.h:115:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/scan.h:97:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/scan.h:34:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:63:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:55:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:48:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:40:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:34:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/cmd.h:14:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:73:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:48:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:382:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:373:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:349:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:344:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:335:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:307:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:294:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl18xx/acx.h:285:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/scan.h:67:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/scan.h:56:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/scan.h:110:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/scan.h:102:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:92:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:82:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:63:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:47:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:32:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/cmd.h:17:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/acx.h:29:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/../wlcore/scan.h:53:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl12xx/../wlcore/acx.h:474:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/wl12xx_80211.h:144:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/wl12xx_80211.h:136:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/wl12xx_80211.h:131:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/wl12xx_80211.h:108:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:96:9: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:377:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:328:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:312:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:300:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:280:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:271:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:234:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:216:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/cmd.h:138:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:89:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:848:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:832:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:817:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:809:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:790:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:783:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:776:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:769:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:762:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:752:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:711:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:697:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:683:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:555:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:510:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:49:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:496:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:485:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:431:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:402:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:381:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:359:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:342:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:330:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:314:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:301:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:267:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:176:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1292:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1235:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:122:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1224:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1201:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1180:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1145:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1137:8: warning: nested flexible arrays
      1 drivers/net/wireless/ti/wl1251/acx.h:1088:8: warning: nested flexible arrays
      1 drivers/net/wireless/rndis_wlan.c:209:15: warning: nested flexible arrays
      1 drivers/net/wireless/rndis_wlan.c:207:8: warning: nested flexible arrays
      1 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1405:8: warning: nested flexible arrays
      1 drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h:1399:8: warning: nested flexible arrays
      1 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1680:8: warning: nested flexible arrays
      1 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1659:8: warning: nested flexible arrays
      1 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1620:8: warning: nested flexible arrays
      1 drivers/net/wireless/quantenna/qtnfmac/qlink.h:1608:8: warning: nested flexible arrays
      1 drivers/net/wireless/microchip/wilc1000/spi.c:50:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:4499:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:4213:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:4203:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:4067:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3957:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3862:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3782:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3753:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3668:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3644:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3603:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3561:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3530:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3499:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3414:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3385:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3355:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3316:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3280:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3208:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3139:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3051:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:3010:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2985:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2955:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2922:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2863:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2829:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2768:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2726:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2667:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2590:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2496:8: warning: nested flexible arrays
      1 drivers/net/wireless/marvell/mwl8k.c:2347:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlwifi/mvm/d3.c:1465:24: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlwifi/fw/dbg.h:83:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlwifi/fw/api/dbg-tlv.h:270:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2473:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlwifi/dvm/commands.h:2344:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlegacy/common.h:521:15: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlegacy/common.h:520:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlegacy/commands.h:2670:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlegacy/commands.h:2526:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/iwlegacy/commands.h:2482:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/libipw.h:469:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/libipw.h:442:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/libipw.h:434:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/libipw.h:420:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/libipw.h:403:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2200.h:690:15: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2200.h:688:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2200.h:505:15: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2200.h:503:8: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2100.h:786:15: warning: nested flexible arrays
      1 drivers/net/wireless/intel/ipw2x00/ipw2100.h:785:8: warning: nested flexible arrays
      1 drivers/net/wireless/ath/wil6210/wmi.c:4024:16: warning: nested flexible arrays
      1 drivers/net/wireless/ath/wil6210/wmi.c:2761:16: warning: nested flexible arrays
      1 drivers/net/wireless/ath/wil6210/main.c:467:16: warning: nested flexible arrays
      1 drivers/net/wireless/ath/wil6210/cfg80211.c:871:16: warning: nested flexible arrays
      1 drivers/net/wireless/ath/ath10k/htt.h:1791:8: warning: nested flexible arrays
      1 drivers/net/usb/hso.c:195:8: warning: nested flexible arrays
      1 drivers/net/ethernet/sfc/vfdi.h:162:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:91:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:86:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:77:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:69:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:63:8: warning: nested flexible arrays
      1 drivers/net/ethernet/netronome/nfp/nfp_net_debugdump.c:57:8: warning: nested flexible arrays
      1 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl.c:23:8: warning: nested flexible arrays
      1 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c:133:8: warning: nested flexible arrays
      1 drivers/net/ethernet/mellanox/mlx5/core/en_accel/tls.h:75:8: warning: nested flexible arrays
      1 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h:246:15: warning: nested flexible arrays
      1 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h:244:8: warning: nested flexible arrays
      1 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h:654:8: warning: nested flexible arrays
      1 drivers/mmc/host/vub300.c:296:8: warning: nested flexible arrays
      1 drivers/mmc/host/vub300.c:153:7: warning: nested flexible arrays
      1 drivers/mmc/core/sdio_uart.c:63:8: warning: nested flexible arrays
      1 drivers/media/usb/siano/smsusb.c:38:8: warning: nested flexible arrays
      1 drivers/md/raid5-ppl.c:135:8: warning: nested flexible arrays
      1 drivers/md/raid5-cache.c:82:8: warning: nested flexible arrays
      1 drivers/md/md-multipath.h:25:8: warning: nested flexible arrays
      1 drivers/md/dm-writecache.c:195:8: warning: nested flexible arrays
      1 drivers/md/dm-thin.c:229:8: warning: nested flexible arrays
      1 drivers/md/dm-clone-target.c:69:8: warning: nested flexible arrays
      1 drivers/md/bcache/writeback.c:761:8: warning: nested flexible arrays
      1 drivers/md/bcache/writeback.c:245:8: warning: nested flexible arrays
      1 drivers/md/bcache/super.c:481:9: warning: nested flexible arrays
      1 drivers/md/bcache/extents.c:427:33: warning: nested flexible arrays
      1 drivers/md/bcache/debug.c:159:8: warning: nested flexible arrays
      1 drivers/md/bcache/btree.c:340:9: warning: nested flexible arrays
      1 drivers/md/bcache/btree.c:2175:25: warning: nested flexible arrays
      1 drivers/md/bcache/btree.c:1089:9: warning: nested flexible arrays
      1 drivers/md/bcache/bset.c:1196:9: warning: nested flexible arrays
      1 drivers/md/bcache/alloc.c:621:9: warning: nested flexible arrays
      1 drivers/md/bcache/alloc.c:544:9: warning: nested flexible arrays
      1 drivers/md/bcache/alloc.c:540:8: warning: nested flexible arrays
      1 drivers/isdn/capi/capi.c:82:8: warning: nested flexible arrays
      1 drivers/ipack/devices/ipoctal.c:30:8: warning: nested flexible arrays
      1 drivers/input/keyboard/applespi.c:296:15: warning: nested flexible arrays
      1 drivers/input/keyboard/applespi.c:290:8: warning: nested flexible arrays
      1 drivers/infiniband/hw/mlx5/devx.c:42:8: warning: nested flexible arrays
      1 drivers/infiniband/hw/mlx5/devx.c:32:8: warning: nested flexible arrays
      1 drivers/infiniband/hw/hfi1/mad.c:63:8: warning: nested flexible arrays
      1 drivers/infiniband/hw/hfi1/firmware.c:149:8: warning: nested flexible arrays
      1 drivers/infiniband/core/uverbs_std_types_flow_action.c:218:8: warning: nested flexible arrays
      1 drivers/infiniband/core/cm.c:238:8: warning: nested flexible arrays
      1 drivers/hwspinlock/stm32_hwspinlock.c:23:8: warning: nested flexible arrays
      1 drivers/hwspinlock/sprd_hwspinlock.c:35:8: warning: nested flexible arrays
      1 drivers/hwspinlock/sirf_hwspinlock.c:21:8: warning: nested flexible arrays
      1 drivers/hv/vmbus_drv.c:1023:8: warning: nested flexible arrays
      1 drivers/gpu/drm/xlnx/zynqmp_disp.c:120:8: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:78:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:377:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/uvmm.c:155:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/ummu.c:109:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/subdev/mmu/umem.c:147:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/engine/disp/rootnv50.c:136:23: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:109:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:86:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:53:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:433:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:300:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:257:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/ioctl.c:168:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/client.c:76:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/client.c:71:8: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/client.c:194:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvkm/core/client.c:133:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/object.c:34:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/object.c:247:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/object.c:171:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/object.c:124:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/object.c:105:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/notify.c:67:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/notify.c:36:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/notify.c:148:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/notify.c:115:21: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/fifo.c:74:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/fifo.c:28:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nvif/client.c:66:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:76:21: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:35:8: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:300:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:268:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:129:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_usif.c:126:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_svm.c:625:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_nvif.c:77:21: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_chan.c:550:16: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/nouveau_abi16.c:370:15: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/dispnv50/disp.c:676:24: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/dispnv50/disp.c:675:25: warning: nested flexible arrays
      1 drivers/gpu/drm/nouveau/dispnv50/disp.c:646:16: warning: nested flexible arrays
      1 drivers/gpu/drm/i915/gvt/opregion.c:116:8: warning: nested flexible arrays
      1 drivers/gpu/drm/amd/amdgpu/si_dpm.h:958:8: warning: nested flexible arrays
      1 drivers/gpu/drm/amd/amdgpu/si_dpm.h:818:8: warning: nested flexible arrays
      1 drivers/crypto/sa2ul.h:326:8: warning: nested flexible arrays
      1 drivers/crypto/picoxcell_crypto.c:79:8: warning: nested flexible arrays
      1 drivers/crypto/padlock-sha.c:23:8: warning: nested flexible arrays
      1 drivers/crypto/marvell/octeontx/otx_cptvf_algs.h:165:8: warning: nested flexible arrays
      1 drivers/crypto/img-hash.c:82:8: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chtls/chtls_io.c:162:16: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chcr_ktls.h:67:8: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chcr_crypto.h:293:8: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chcr_core.h:172:8: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chcr_core.h:165:8: warning: nested flexible arrays
      1 drivers/crypto/chelsio/chcr_core.h:137:8: warning: nested flexible arrays
      1 drivers/crypto/atmel-aes.c:161:8: warning: nested flexible arrays
      1 drivers/crypto/amlogic/amlogic-gxl.h:109:8: warning: nested flexible arrays
      1 drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h:188:8: warning: nested flexible arrays
      1 drivers/clk/sifive/fu540-prci.c:145:8: warning: nested flexible arrays
      1 drivers/clk/samsung/clk-exynos5433.c:5499:8: warning: nested flexible arrays
      1 drivers/clk/clk-bm1880.c:62:8: warning: nested flexible arrays
      1 drivers/clk/bcm/clk-bcm63xx-gate.c:23:8: warning: nested flexible arrays
      1 drivers/clk/bcm/clk-bcm2835.c:313:8: warning: nested flexible arrays
      1 drivers/char/ttyprintk.c:20:8: warning: nested flexible arrays
      1 drivers/char/pcmcia/synclink_cs.c:137:16: warning: nested flexible arrays
      1 drivers/char/../tty/hvc/hvc_console.h:35:8: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:719:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:613:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:57:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:549:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:438:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:367:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:329:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:284:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:241:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:199:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:155:16: warning: nested flexible arrays
      1 drivers/acpi/nfit/intel.c:122:16: warning: nested flexible arrays
      1 crypto/xts.c:33:8: warning: nested flexible arrays
      1 crypto/lrw.c:52:8: warning: nested flexible arrays
      1 crypto/essiv.c:59:8: warning: nested flexible arrays
      1 crypto/cts.c:59:8: warning: nested flexible arrays
      1 crypto/cryptd.c:79:8: warning: nested flexible arrays
      1 crypto/chacha20poly1305.c:51:8: warning: nested flexible arrays
      1 crypto/chacha20poly1305.c:45:8: warning: nested flexible arrays
      1 crypto/chacha20poly1305.c:33:8: warning: nested flexible arrays
      1 crypto/algif_hash.c:19:8: warning: nested flexible arrays
      1 crypto/adiantum.c:76:8: warning: nested flexible arrays
      1 crypto/adiantum.c:120:16: warning: nested flexible arrays
      1 ./include/uapi/linux/wmi.h:40:8: warning: nested flexible arrays
      1 ./include/uapi/linux/sctp.h:633:7: warning: nested flexible arrays
      1 ./include/uapi/linux/fuse.h:817:8: warning: nested flexible arrays
      1 ./include/sound/sof/ext_manifest.h:82:8: warning: nested flexible arrays
      1 ./include/rdma/ib_verbs.h:2121:8: warning: nested flexible arrays
      1 ./include/net/tls.h:99:8: warning: nested flexible arrays
      1 ./include/net/netfilter/nf_conntrack_timeout.h:20:8: warning: nested flexible arrays
      1 ./include/linux/sctp.h:617:8: warning: nested flexible arrays
      1 ./include/linux/sctp.h:600:8: warning: nested flexible arrays
      1 ./include/linux/sctp.h:442:8: warning: nested flexible arrays
      1 ./include/linux/sctp.h:345:8: warning: nested flexible arrays
      1 ./include/linux/mlx5/mlx5_ifc.h:5049:8: warning: nested flexible arrays
      1 ./include/linux/mlx5/mlx5_ifc.h:4838:8: warning: nested flexible arrays
      1 ./include/linux/mlx5/mlx5_ifc.h:4683:8: warning: nested flexible arrays
      1 ./include/linux/mlx5/mlx5_ifc.h:4352:8: warning: nested flexible arrays
      1 ./include/linux/mlx5/mlx5_ifc.h:1980:8: warning: nested flexible arrays
      1 ./include/linux/greybus/greybus_protocols.h:2018:8: warning: nested flexible arrays
      1 ./include/linux/greybus/greybus_protocols.h:2002:15: warning: nested flexible arrays
      1 ./include/linux/greybus/greybus_protocols.h:1999:8: warning: nested flexible arrays
      1 ./include/linux/cyclades.h:119:8: warning: nested flexible arrays
      1 ./include/asm-generic/hyperv-tlfs.h:440:8: warning: nested flexible arrays
      1 ./include/asm-generic/hyperv-tlfs.h:434:15: warning: nested flexible arrays
      1 ./include/asm-generic/hyperv-tlfs.h:431:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tx.h:801:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tx.h:782:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tdls.h:184:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tdls.h:137:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tdls.h:121:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/tdls.h:109:8: warning: nested flexible arrays
      1 ./drivers/net/wireless/intel/iwlwifi/mvm/..//fw/api/scan.h:820:8: warning: nested flexible arrays

--5nbwgbmmt77zv6lj--

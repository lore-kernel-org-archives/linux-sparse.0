Return-Path: <SRS0=XUoR=DI=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF4DC4727E
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D873A20780
	for <linux-sparse@archiver.kernel.org>; Thu,  1 Oct 2020 19:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Avm1kC60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgJATvX (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 1 Oct 2020 15:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729990AbgJATvX (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 1 Oct 2020 15:51:23 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC27DC0613D0
        for <linux-sparse@vger.kernel.org>; Thu,  1 Oct 2020 12:51:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so46370wrm.9
        for <linux-sparse@vger.kernel.org>; Thu, 01 Oct 2020 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P9+hPs3vuaIHOsoAswW6tJYndKVxaPkOxb07nrPwu2E=;
        b=Avm1kC60nswY4Zv/D6kf99/TDaB562we1pllOYt7/gB/xaOAXC/aC8kyQNt4lL48LY
         MGRWYkASmYJa0Thm9jGlQbmKu9duZ9g2NrON3jkS70RSEYut852OYD09zu4MnUCR834A
         ddbh5F3Y1tTvybByhrPayI7pI+71cugIirZEqJf7XAhW79qFxurjccteYZZ338AYkyRf
         Bcu+9N3fa4Oie2yn9uDnfStv3vhoKSNvYOCADAdGKm001RewMwk0nndi5KitSsj8F1rc
         WNBX2PpMJaMz7hwiQRzwK74eCDTnwArVsPVUnBaMx2bUcmvSQm80DK4tSQT+qCO260fK
         x7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P9+hPs3vuaIHOsoAswW6tJYndKVxaPkOxb07nrPwu2E=;
        b=PNeTgHJYPcsrVzCzHrB/5mobv6fosukKDZhMotPd78c8QJKu64qEUQxDl/ueos7Bta
         N7qosUArfbZ6do7xXCznUrR/vwZQ5B7kzhBVBNRMay2KigbwmUHsP14QmrP8xHuO5XI2
         9X6WxOM6dXAbPvBn6UnXrzGvn6O6unCaZQ7erwecc+QcaJ0uUsKY9kO09wVnD/ozm55c
         b9PNvL/NcAv6FgIG1lF23puCK71ETBr8TxqMUYHH7Vg09YLn2JHZTNSUH2Rq1jUM2bb5
         qglJWmb6/YtdEvpo4OqdAWvLgirWi8Xqwuw41FCFjdfi2g3vNnVHYMRVHxtJizTOZZdL
         HSBw==
X-Gm-Message-State: AOAM532NwngXtJ5Ab1Fz+jnZ/U/nACHfm/5h03VceXgRBLz3H/b1k/cd
        xdrTp754p6jlGH8v9LueR2detK7HaRk=
X-Google-Smtp-Source: ABdhPJxfTGhKtU5gBtOwVthkdaEbap6pKvSw0P20Z7SzNvrrwotjAlZMAy/NAP+8w2pj+9fpxxvivA==
X-Received: by 2002:adf:e54f:: with SMTP id z15mr10395258wrm.136.1601581881554;
        Thu, 01 Oct 2020 12:51:21 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:853c:f0a7:910c:921f])
        by smtp.gmail.com with ESMTPSA id u66sm1458606wme.12.2020.10.01.12.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 12:51:21 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:51:20 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: [PATCH 13/13] flex-array: warn when a flexible array member has
 some padding
Message-ID: <20201001195120.yhnrsq54ojfuy7lr@ltop.local>
References: <20200930231828.66751-1-luc.vanoostenryck@gmail.com>
 <20200930231828.66751-14-luc.vanoostenryck@gmail.com>
 <CAHk-=wiyAWuHQuDPBC290V-Bx5Eyu1izPj9iSSN0hdkSM2a4iQ@mail.gmail.com>
 <20201001191706.nefotol6m2oqrtcg@ltop.local>
 <CAHk-=wh7LNGQ5aDtJeRzkLPUewUjgoc3eiKF_Yh81kfU-XPHCw@mail.gmail.com>
 <20201001194121.2lk6e66zycgtoqkw@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001194121.2lk6e66zycgtoqkw@ltop.local>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 01, 2020 at 09:41:21PM +0200, Luc Van Oostenryck wrote:
> On Thu, Oct 01, 2020 at 12:27:56PM -0700, Linus Torvalds wrote:
> > On Thu, Oct 1, 2020 at 12:17 PM Luc Van Oostenryck
> > <luc.vanoostenryck@gmail.com> wrote:
> > >
> > > > So in the kernel, we would
> > > >
> > > >  - start warning about 'sizeof(flex_struct)'
> > >
> > > Adding this warning by default annoys me slightly because it will
> > > add 5700+ warnings to the 18000 already present and I think sparse
> > > is already underused because it is very/too noisy. But I guess that
> > > most occurrences come from a few macros and thus should be easy to
> > > get rid off.
> > 
> > Hopefully. I'll try to take a look. Do you have the sparse changes in
> > a git branch already so that I can just try that directly?
> 
> What I posted yesterday is on
> 	git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git flex-array
> 
> > Or if you send me a couple of examples, maybe it's just the same
> > pattern over and over,..
> 
> Well, the 888 occurences I see are already 'unique' occurences
> (in the sense that the warning is from a distinct file+position).
> I'm adding in attachment the extract of my test logs (but it is
> on v5.9-rc1 so it's maybe not much usefull). I ddn't investigated
> anything, just checked a few case to see that it was a genuine
> occurrence.

Sorry, I was thinking about the nested ones and sent the wrong.
Here are the top entries for sizeof():
     66 ./include/linux/filter.h:752:16: warning: using sizeof on a flexible structure
     48 crypto/gcm.c:547:17: warning: using sizeof on a flexible structure
     48 crypto/authencesn.c:357:17: warning: using sizeof on a flexible structure
     48 crypto/authenc.c:339:17: warning: using sizeof on a flexible structure
     44 ./include/linux/ihex.h:26:38: warning: using sizeof on a flexible structure
     30 drivers/crypto/chelsio/chcr_algo.c:793:32: warning: using sizeof on a flexible structure
     29 ./include/crypto/skcipher.h:518:31: warning: using sizeof on a flexible structure
     27 ./include/linux/can/dev.h:100:13: warning: using sizeof on a flexible structure
     24 net/mac80211/tdls.c:874:32: warning: using sizeof on a flexible structure
     24 net/ipv6/ndisc.c:1662:18: warning: using sizeof on a flexible structure
     24 drivers/tty/tty_buffer.c:352:28: warning: using sizeof on a flexible structure
     24 drivers/tty/tty_buffer.c:316:28: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:972:25: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:968:32: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:961:29: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:905:25: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:897:29: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:760:49: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:756:55: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:747:62: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:738:49: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:729:53: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:577:33: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:559:39: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:554:41: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:404:29: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:1134:33: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:1118:55: warning: using sizeof on a flexible structure
     23 net/netfilter/ipset/ip_set_hash_gen.h:1114:51: warning: using sizeof on a flexible structure
     20 fs/proc/inode.c:110:9: warning: using sizeof on a flexible structure
     20 fs/proc/inode.c:109:17: warning: using sizeof on a flexible structure
     20 fs/proc/generic.c:425:29: warning: using sizeof on a flexible structure
     18 net/ipv4/tcp_output.c:1241:28: warning: using sizeof on a flexible structure
     18 net/core/net-sysfs.c:769:23: warning: using sizeof on a flexible structure
     17 ./include/linux/ihex.h:52:50: warning: using sizeof on a flexible structure
     16 fs/proc/inode.c:107:35: warning: using sizeof on a flexible structure
     16 ./include/crypto/skcipher.h:496:23: warning: using sizeof on a flexible structure
     15 mm/percpu.c:2259:21: warning: using sizeof on a flexible structure
     14 drivers/net/ethernet/chelsio/cxgb4/cudbg_lib.h:281:27: warning: using sizeof on a flexible structure
     13 drivers/net/wireguard/messages.h:117:34: warning: using sizeof on a flexible structure
     13 ./include/crypto/hash.h:594:23: warning: using sizeof on a flexible structure
     12 net/netfilter/x_tables.c:780:21: warning: using sizeof on a flexible structure
     12 net/netfilter/x_tables.c:1157:21: warning: using sizeof on a flexible structure
     12 net/netfilter/ipset/ip_set_hash_gen.h:143:51: warning: using sizeof on a flexible structure
     12 net/netfilter/ipset/ip_set_hash_gen.h:139:29: warning: using sizeof on a flexible structure
     12 net/mac80211/iface.c:1829:28: warning: using sizeof on a flexible structure
     12 net/core/skbuff.c:6188:26: warning: using sizeof on a flexible structure
     12 net/core/skbuff.c:6146:39: warning: using sizeof on a flexible structure
     12 net/core/skbuff.c:4214:16: warning: using sizeof on a flexible structure
     12 net/core/bpf_sk_storage.c:666:32: warning: using sizeof on a flexible structure
     12 net/core/bpf_sk_storage.c:1081:9: warning: using sizeof on a flexible structure
     12 kernel/module.c:1601:19: warning: using sizeof on a flexible structure
     12 kernel/bpf/core.c:881:16: warning: using sizeof on a flexible structure
     12 drivers/staging/greybus/sdio.c:136:20: warning: using sizeof on a flexible structure
     12 drivers/infiniband/hw/cxgb4/provider.c:278:31: warning: using sizeof on a flexible structure
     12 drivers/gpu/drm/drm_managed.c:92:13: warning: using sizeof on a flexible structure
     12 drivers/crypto/picoxcell_crypto.c:711:17: warning: using sizeof on a flexible structure
     12 crypto/cmac.c:271:17: warning: using sizeof on a flexible structure
     12 crypto/cmac.c:266:17: warning: using sizeof on a flexible structure
     12 crypto/chacha20poly1305.c:528:17: warning: using sizeof on a flexible structure
     12 crypto/adiantum.c:429:23: warning: using sizeof on a flexible structure
     11 ./include/uapi/linux/bcache.h:101:17: warning: using sizeof on a flexible structure
     11 ./include/crypto/aead.h:414:23: warning: using sizeof on a flexible structure
     10 drivers/infiniband/sw/rxe/rxe.h:76:9: warning: using sizeof on a flexible structure
     10 drivers/base/devres.c:95:13: warning: using sizeof on a flexible structure
     10 ./include/rdma/rdmavt_qp.h:535:39: warning: using sizeof on a flexible structure
     10 ./include/rdma/ib_verbs.h:583:25: warning: using sizeof on a flexible structure
     10 ./include/crypto/hash.h:990:26: warning: using sizeof on a flexible structure
     10 ./include/crypto/akcipher.h:196:23: warning: using sizeof on a flexible structure

Less frequent ones removed. There is a lot with a single occurence
mostly in drivers/.


-- Luc


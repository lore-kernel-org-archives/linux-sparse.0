Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CCCC2BB9A
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DAFA22CB2
	for <linux-sparse@archiver.kernel.org>; Tue, 15 Dec 2020 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgLOU5G (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 15 Dec 2020 15:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgLOU5C (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 15 Dec 2020 15:57:02 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB209C06179C
        for <linux-sparse@vger.kernel.org>; Tue, 15 Dec 2020 12:56:21 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id m5so21176835wrx.9
        for <linux-sparse@vger.kernel.org>; Tue, 15 Dec 2020 12:56:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9ovRUwuEljcQuL18NWRr0AkkDMKu6FWxXfkgKog09Ag=;
        b=MqFnFYUQrPc4xxH5NXiS/NrMbG7ce7Phjv/YKdMURnr573hbSZvp7/QULqVOKXzuhf
         SE998dO14FSGLOeuNZCcG0IQf0iqaV+CAqDxwyE3FE7XLG4JUP4VXsg8vZZ3pig18IEC
         Urdng+CKj/4X6yOT8aHlc627gN+ISH1/xGg5r3Mlq+KWPsY1eO6nmm2r3k7xqMt6K4jY
         Lfu+IMPQVy8lhLGRGh/tMYg/7HuXP+yU2NF0URlJYqx4Q+SvNtLzBhU5NGTKiOMGSsfp
         tTNpSti30Uz6myCxbgWRhEnhqnZ5bL2Tjdlm4lca2oZTuooxbweFQ1+bHDzfc6pRLZQi
         R85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9ovRUwuEljcQuL18NWRr0AkkDMKu6FWxXfkgKog09Ag=;
        b=DtxEelxwZ4JbARKnvx3ymDlXHd41/qbCrQ4yhsGL9z6Dty4UoSfcOfV9FDgDIpl65n
         T5RJnHZVWCKYfACoDgfX7WJcUEpV1cVKQHBISZNy9TDnfdy8KDjRuJGaFSPlJTyzWXpn
         1tGWt04RGDS79IZd+emJNLHCtPhpdywzzHMtTMfVPwpiY1vlZ91puZ+fh1YXR333/cMC
         MiiVRgcGQpybyAkCgrLORWeEfKBX4EKwo9g/+S2X2HYX/FTC1vVZ0spKUteaCWjdyIhZ
         LeLkmHZACt8DAYftGe571Ff8ZMnAjFRDL23xX+L1nPvQfJGN/fmF36PGZiPpNkhw3qRV
         BSxg==
X-Gm-Message-State: AOAM533htjvDD33MhQpi5tJll1JxJaHldsN/TgN3ggJh3sBLQSwm0A6d
        DRbv+whhH3c1vufBjZ4sBU0=
X-Google-Smtp-Source: ABdhPJxwisR0pSvIECkZX+1d2dzPqSTLW/Kr2Zhzk4UHErZg4fb3gsMXOb0KxuyOy1PAVX6Rx1RFow==
X-Received: by 2002:a5d:530c:: with SMTP id e12mr4466039wrv.54.1608065780543;
        Tue, 15 Dec 2020 12:56:20 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:653d:e949:bd1c:ec2a])
        by smtp.gmail.com with ESMTPSA id k1sm11098954wrn.46.2020.12.15.12.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:56:19 -0800 (PST)
Date:   Tue, 15 Dec 2020 21:56:18 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse attribute packed on structures
Message-ID: <20201215205618.scarwvtzzhhtdwvk@ltop.local>
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Dec 15, 2020 at 10:15:35AM -0800, Jacob Keller wrote:
> Hi,
> 
> I'm looking into an issue with sparse not calculating the size of a
> packed structure correctly, causing some static assertions to fail due
> to an incorrect size.
> 
> With a structure like this:
> 
> struct a {
> 	uint32_t a;
> 	uint8_t b;
> 	uint8_t c;
> } __attribute__ ((packed));
> 
> The packed attribute doesn't seem to get applied to the whole structure.
> Thus, the sparse sizeof evaluation for this results in 8 bytes (64
> bits), when GCC would produce a structure of size 6 bytes (48 bits).
> 
> If I use something instead like this:
> 
> struct a {
> 	uint32_t a __attribute__ ((packed));
> 	uint8_t b __attribute__ ((packed));
> 	uint8_t c __attribute__ ((packed));
> } __attribute__ ((packed));
> 
> Then the size is calculated correctly.
> 
> I saw that there is support in parse.c for parsing attribute packed, but
> it doesn't seem to have a way to propagate from a structure down to its
> members.
> 
> I thought it would be relatively straight forward to implement by adding
> a MOD_PACKED, but that doesn't seem to actually get assigned to the
> struct symbol, so when I tried that it didn't work.
> 
> I would very much like to help get structure size packing to work properly.
> 
> The following diff is what I tried initially, but it doesn't actually
> work as expected. I'm not sure what is wrong, or what is the best method
> to actually get the packed modifier to save into the structure symbol so
> that it can be checked when determining the structure size.
> 
> Help would be appreciated.

Hi,

There is at least 3 issues with the packed attribute:
1) at parsing time, types attributes are not applied to the
   corresponding symbol,
2) the size calculation must take the attribute in account,
3) the linearization of memory access must be adapted to be able
   to access unaligned members otherwise the check access complain
   loudly.

Sorry, I don't have much time for this now but at first sight your patch
seems on the right track. I can look at it more closely this WE but
meanwhile I've pushed a branch 'packed' on
	git://git.kernel.org/pub/scm/devel/sparse/sparse-dev.git

This branch contains an unfinished patches but it should more or less
handle the points 1) & 2) and circumvent point 3) by disabling access
checking for bitfields.

I hope this will help you,
-- Luc

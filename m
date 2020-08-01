Return-Path: <SRS0=AFCr=BL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7BCC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 16:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E373C2068F
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 16:54:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sO9RAzD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725841AbgHAQy1 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHAQy1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Aug 2020 12:54:27 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07479C06174A
        for <linux-sparse@vger.kernel.org>; Sat,  1 Aug 2020 09:54:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so34445062eje.7
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2020 09:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IJ2SONVJgEKCrGgr1w4MIDDsdWRwipSX3QDFHEdTK3A=;
        b=sO9RAzD3j+AAL9GC6ko2ICo6xsPKj1sNPz/+ejMOXDoMSyKX33vscUSAVek3IxC+G/
         +q0jzcOwOPvqXXzVFJG67auL+XcdeqZkubTUr/AbfAebma3slt9LC6sAhtv4FmPA9e4t
         CKT+CH3EMKtZoGxTRLD0GQENW4t2kdcvs/ZQBBwyL89UINKH0YFNysW7wAxvJF+5OE7q
         wgizE/ReJWsqZ6PpjIacYnHiCB4GnE4iwVP051AIBR+9crL7YBEhhWJ55GSvqbdtEmbd
         bicgx+DhH2PKptz/s8WptuYfjGaJAOwSlEl9kmhizXz4kgyIisGiZo/R4FeWbgTQhwGZ
         S+vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IJ2SONVJgEKCrGgr1w4MIDDsdWRwipSX3QDFHEdTK3A=;
        b=Is9gOphnuy4gNeFtYDkQSnSh00xy5Idc/7d3STDbwnzwtoXvGhSKtI9XUCCN2LkAdQ
         zb/lknfxiwtCf8Z29/nrhPMi6Fenj+bodDM4pNQWylypgau54aJRaqNo0hczRDVsAXpf
         s7ySTzQkz4DXGCcisDvyXn/L19NXok/MUg2aOGdTNbCNJ0cEWqv2cCM5bA8f3wiQYkdh
         BSlI+yLCtmgPJj+vjCZANmc4K7mm4hkYglZMBU8vqWkLurirT5ALbuT0sAN/dYCu1jcV
         rwJe7EA7/7VR1zijrsC+tP3UsBxFeqLYzyAY9qJbRuKlmj2krb2NIanHVPPEokIPosIe
         ppvQ==
X-Gm-Message-State: AOAM530UgJeRfSV+gxxlx44QQNwsdwdLR1080MmGwxMAsYSMlGV8lnt+
        lY8G3wweCtUzhdYeuRN8jucUXJy5
X-Google-Smtp-Source: ABdhPJyJnV7nFLTqCFxaz+bdhDr6x8x3fRuqnDp5yvoNxMnTS1xPf+t1ZKKYfjbkQ87NNDXFiJ1K2Q==
X-Received: by 2002:a17:906:15c2:: with SMTP id l2mr9177140ejd.112.1596300865775;
        Sat, 01 Aug 2020 09:54:25 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:bcb6:41f8:5910:1a43])
        by smtp.gmail.com with ESMTPSA id z9sm10653869ejj.51.2020.08.01.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 09:54:25 -0700 (PDT)
Date:   Sat, 1 Aug 2020 18:54:24 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+7f2b156a8ad4ece3334e6b9712c2de05@salsa.debian.org>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200801165424.e5uxzbpwrkt3suo6@ltop.local>
References: <reply-7f2b156a8ad4ece3334e6b9712c2de05@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_184887@salsa.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <note_184887@salsa.debian.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Aug 01, 2020 at 06:51:42AM +0000, Uwe Kleine-König wrote:
> Uwe Kleine-König commented:
> 
> 
> What I didn't do compared to your MR is to add the patch "gensel: remove unneeded test/uninitialized warning" to fix a build warning.

I've added a 'maintenance' branch on the official tree: 
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git maint-v0.6.2

which contains a few fixup patches I think the Debian release should have.
It contains, the 'gensel' patch here above (not very important, it just fix
a warning), your patch for sindex.1 (same), the build fix for Hurd and
most importantly it contains a patch for a real bug making sparse crash:
  77f35b796cc8 ("generic: fix missing inlining of generic expression")

Thanks,
-- Luc

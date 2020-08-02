Return-Path: <SRS0=4hY4=BM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736D5C433DF
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 13:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 441AA2075A
	for <linux-sparse@archiver.kernel.org>; Sun,  2 Aug 2020 13:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T7iEjzBg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHBN3k (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 2 Aug 2020 09:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHBN3j (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 2 Aug 2020 09:29:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B962C06174A
        for <linux-sparse@vger.kernel.org>; Sun,  2 Aug 2020 06:29:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id bo3so13302916ejb.11
        for <linux-sparse@vger.kernel.org>; Sun, 02 Aug 2020 06:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DiMrPhAhB1qGgxvzs+t7vURK7v9V73LPhlViRF7lREw=;
        b=T7iEjzBgaJgBRI9EQLnTQ6K5moTkPGI1JAZ0Y2PNU2DeVCnCQc2NLkqDcUJMcdxHvU
         qXEYU6OEgJ0Yc7WxI7hI3yu9u1Hn1X9hG3ZR7TAqLsce5bgd3wtJpV+J7EMJrkPcsXe1
         T7K6IdMQyZonI0S24kjtcjlxfwbd+DqIDQB0Q8VL3/BPA8VAA2kU/0MmZGdNerZjnF7K
         jiWZap+MW8J0gnijQaPEDcjbNft0Bac9OIM9J/es6BTJ5p1UVJsYfJ6IkSumZAM6EnAI
         MT0TffHRFfjt7hs0tJfM0G/TqxWTP7MP6LVUsG9X9Pf7z3t9VUACRqpt5pBQvW9wQtVO
         hJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DiMrPhAhB1qGgxvzs+t7vURK7v9V73LPhlViRF7lREw=;
        b=ZQ5quA03Zgm7CUdtmIGQQqZer0douZ949iudFlGjZi2inIW8pFY/W7N45JVmlW9npp
         zjCPfaG8w58Z7hlWPEhMVpKbEC5Ew+D/Bwk3u4EP3aGexvG1e1BWjPYr+Q1HvEHy9775
         3QDYZNdkyVbIkq62wQ+ATeGxr6VHG1d1Y0YxWueU3TrioUCuB3qEfLSTcpI3f1dcuQQq
         c0fg4F9tjEndqpUz4JJS5BOOjRXnE4LcEVdOJU+nOFm2xK/2zzQq+TDlKUlyHM0Ydqn6
         R8ZIE/DcA6alF+SA7Maquqjl+2bO9RqRV98u6DOAXK5ZuHEZ4s2o6pEvcfFrQkkXCF45
         irdA==
X-Gm-Message-State: AOAM532CTj1Frl6RN7EOGtjAWt2vzpoKS5vpZhBLBtgwSGk5CHF3UD6G
        oSCP/Ta7nU7iz2bSNKuT3i8eJm02
X-Google-Smtp-Source: ABdhPJy8YJ6jf3QobrR9Vq1vSz4jiOLg4e70l1nNTx3HRSag1sXgLB5Dpxmx36PECVhyiZTu6rqVhQ==
X-Received: by 2002:a17:906:c002:: with SMTP id e2mr12974501ejz.244.1596374977799;
        Sun, 02 Aug 2020 06:29:37 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:45:f0a:11a2:cdb])
        by smtp.gmail.com with ESMTPSA id s16sm13173352ejr.31.2020.08.02.06.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 06:29:37 -0700 (PDT)
Date:   Sun, 2 Aug 2020 15:29:36 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+f2c7a505ea576c194910ce335a7779a8@salsa.debian.org>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200802132936.zxna7fwhc3gg7gdx@ltop.local>
References: <reply-f2c7a505ea576c194910ce335a7779a8@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_184882@salsa.debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <note_184882@salsa.debian.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

For the build failure on X32:
  /usr/include/x86_64-linux-gnux32/gnu/stubs.h:7:12: error: unable to open 'gnu/stubs-32.h'

Sparse should be called with '--arch=x86_64 -mx32' but the error
indicate that '__x86_64__' is not even defined, as if another
architecture was selected. Very strange.
I can't reproduce this here (nor in my old setup, nor in a brand
new reinstall of a x32 chroot).


The output of:
   env CHECK=./sparse ./cgcc -v -no-compile memops.c
should be:
  ./sparse -v --arch=x86_64 <lots of defines for floats> -mx32 --os=linux -gcc-base-dir /usr/lib/gcc/x86_64-linux-gnux32/10/ -multiarch-dir x86_64-linux-gnux32 memops.c

I absolutely don't see what can be wrong. But I wonder why it
happens first or only on memops.c and not on one of the file
listed earlier, for example allocate.c?

-- Luc

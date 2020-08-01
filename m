Return-Path: <SRS0=AFCr=BL=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42DFC433E0
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 12:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60A12080C
	for <linux-sparse@archiver.kernel.org>; Sat,  1 Aug 2020 12:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW5PedkT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgHAMkH (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbgHAMkH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 1 Aug 2020 08:40:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F72C06174A
        for <linux-sparse@vger.kernel.org>; Sat,  1 Aug 2020 05:40:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id kq25so21090092ejb.3
        for <linux-sparse@vger.kernel.org>; Sat, 01 Aug 2020 05:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PGbz/OpeBla9RGB3CeXqtRVY1IuI1iNB3/7tdyAf5Eg=;
        b=NW5PedkTWLW3iCLdMWuFZma5QQV1QgCEkCrg7pVTE+YFgeq3gLTMW2DzGn21UhJVij
         vtYWhenfCLAaSlElujRy32bE8ibzxkV9/OWj9O7V4l0L7y/4Z0ZTDP1U4IaPp0x5ry3B
         6Hs3pvtxovQ3eRqvvKrfTyFL/1xxNB9Wk0321YaEfCPBrCOoQwHeKFG0rX2E2zf+wH3m
         Y4deCRjqywOudz3aEhDsW+kjLbib+zciV7th9xJNxnGoxff7VKr8KUurV9hzmHA+yHjq
         B8+MWbcdQimQGo/PvKcprLLkSKA09ie0af4m99VZ25/qcca2+YidGT3qRwNo6sjhKYfw
         5hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PGbz/OpeBla9RGB3CeXqtRVY1IuI1iNB3/7tdyAf5Eg=;
        b=pZPxKXh/ALiXktkt2/pg21b7Ajz6y1EluP7itLz1CI8rHQsoL7s9Ydl3jhI93gapB5
         6IaS2sBM36VB2ODpQDd8z6shMBLrVyl4zDcsPOFZEWgOhfvMU3male42x2gzTcezd6FJ
         dWPkNgVXdRsbHc+OeH702S7O7U8QhD+pCu07FsURMwI0kkBbQIDfsyNiJEO9LUehiOLk
         j/Gei4pnKQMjrB+AumshcDVnNPrcD8D3cWcmPmCBdnkbcd9wXnqA+QjYb79qzNfPvShc
         HmqKXfnspZ8A62+JVBOzJXhFTjdQqynjipOCrgFcKmTZ3vRcn+0xewGoCG6l5Qs56268
         u/qA==
X-Gm-Message-State: AOAM533UCNMLss2G0tM0DfcPKErMEwG+P8KGXZ6RJ5DBnQGLdJcsuYGV
        QrRMxm65btZzvJXEnhPgeE0=
X-Google-Smtp-Source: ABdhPJwxZIRF0D5a7+EAKZZ7PDW74Jmt1q+h2ORdx3u6PjZIoAqvNqmV/si6sYCn3cKTW20OYSeVJg==
X-Received: by 2002:a17:906:31c8:: with SMTP id f8mr8213642ejf.269.1596285605281;
        Sat, 01 Aug 2020 05:40:05 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:75e4:71f5:294d:53f6])
        by smtp.gmail.com with ESMTPSA id mj22sm11338541ejb.118.2020.08.01.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 05:40:04 -0700 (PDT)
Date:   Sat, 1 Aug 2020 14:40:04 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     linux-sparse@vger.kernel.org,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Subject: Re: [PATCH] sindex.1: Use ' for a plain quote char
Message-ID: <20200801124004.567443cwhacqf2i3@ltop.local>
References: <20200731214125.21424-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200731214125.21424-1-uwe@kleine-koenig.org>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Jul 31, 2020 at 11:41:25PM +0200, Uwe Kleine-König wrote:
> --- a/sindex.1
> +++ b/sindex.1
> @@ -128,8 +128,8 @@ struct member
>  .
>  .SH MODE
>  The \fBMODE\fR is dumped as a 3-letter string. The first letter denotes address
> -of part, 2-nd - access by value, 3-rd - access by pointer. A special value
> -\'\fIdef\fR\' means a symbol definition.
> +of part, 2-nd - access by value, 3-rd - access by pointer. A special
> +value '\fIdef\fR' means a symbol definition.

This looks good to me.
Thanks.

But maybe, in this case the single quotes are even not needed at all
since the symbol is already emphasized with the italic? Or the italic
is not needed because it's already between quotes?
Alexey, do you have any preferences?

-- Luc

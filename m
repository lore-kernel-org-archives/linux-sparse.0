Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80008C433E0
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503C62222A
	for <linux-sparse@archiver.kernel.org>; Mon, 28 Dec 2020 23:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgL1Wzu (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgL1UBG (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 28 Dec 2020 15:01:06 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156CC0613D6
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:00:25 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id 91so12367941wrj.7
        for <linux-sparse@vger.kernel.org>; Mon, 28 Dec 2020 12:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IAS1YZn9UJ5D6ATZOMDxBKUf745dOmm7taqmQRj9of0=;
        b=eoVpV1HxDYhr/E2UnxUxZ3srx5AkcZueipIs9uFzgLdr5rGdfNN1QE2kUofWU+7DML
         WTpmivmUeh/kKYgs7GGuA+KlpxiXseWoTON2vfYWilfMlz4btOHx15Jphm5elr7I5OV/
         kSLXS93ZV6S1cmjqzwgKYh4OQYnmcXvoH8/u+tAJVGayhB3kMXCfGSXug2Ux4Frz2o3B
         HtPBLjBlv6aa4ICW3//Nn2JD/9yyQGC4bUBZPdjU7RyECIkttN4W8bzl1MyITYmBV/1P
         rs9OOf5ZckOjIjbLXwLV2YQ3cLOZcONTnfGjsk7cbaqm8pbLyLJ677uDYtXWqgOAFiX+
         Vp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAS1YZn9UJ5D6ATZOMDxBKUf745dOmm7taqmQRj9of0=;
        b=hdu2FDsU5JiRI4T4ZhIZteXRjUKf7CZSlDSVblHF7Sv90XzDQAqAfMXf4wHzsvevTJ
         MXawPjhgqHE/mOkKV2KLn7WVmdTGNIuHBtgf662L/iBxI4oBCGxTrsXUjOhPm9+PjkqG
         JCjMMCJyJMt8OR8IHbXWbuPWwUI/xZYNI6IgoX2gDS0kAWlrw8izkr0NQmYKCp6/V5sV
         tvrLGx2fDzS3OhTsCbnMBdoJwbwOhB9Pk2eRfpia7rUxzAYZH89+Vy3U9CHA0ltYShuS
         NjBRbh55WBkd/Ez6g3Lb1yrcSp2jm0I1g6i1qf1p4hnZ6a62X2WPKFJs/Mm7cSKCMssn
         fzxw==
X-Gm-Message-State: AOAM5321nHZLnWXM+/1lwL38UUvkClyKyx752vT88izD1umhWyxLNrPc
        ueFNfoBb2Ajkfi8ONn/ES1w=
X-Google-Smtp-Source: ABdhPJxoYs7j+232nNJTXFVsHBf7FLPAL1WITAYg/dHQUlY75MfOFL4PLU+Wvol8XyNNDsTF7pef9g==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr53068616wrq.19.1609185624786;
        Mon, 28 Dec 2020 12:00:24 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:1cf:be4f:91b8:4ca6])
        by smtp.gmail.com with ESMTPSA id s205sm371893wmf.46.2020.12.28.12.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 12:00:24 -0800 (PST)
Date:   Mon, 28 Dec 2020 21:00:23 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 02/16] add testcases for exotic enum values
Message-ID: <20201228200023.dyrfyyv656wu6svo@ltop.local>
References: <20201226175129.9621-1-luc.vanoostenryck@gmail.com>
 <20201226175129.9621-3-luc.vanoostenryck@gmail.com>
 <c1fad238-d585-d8b7-1b1a-70fd43982b1e@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1fad238-d585-d8b7-1b1a-70fd43982b1e@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Dec 28, 2020 at 04:10:06PM +0000, Ramsay Jones wrote:
> 
> 
> On 26/12/2020 17:51, Luc Van Oostenryck wrote:
> > There is more than one complexity in the evaluation of enums.
> > 
> > Add a test for enums with 'exotic' values non-covered in other tests.
> 
> s/non-covered/not covered/

Yes, indeed. Thanks.
-- Luc 

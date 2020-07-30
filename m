Return-Path: <SRS0=kwZw=BJ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115DCC433DF
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 20:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB95420829
	for <linux-sparse@archiver.kernel.org>; Thu, 30 Jul 2020 20:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rerB5xtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgG3UGj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgG3UGj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 30 Jul 2020 16:06:39 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E05C061574
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jul 2020 13:06:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id df16so4519135edb.9
        for <linux-sparse@vger.kernel.org>; Thu, 30 Jul 2020 13:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhCLpLFtINueWxzzt4Ji/MumhbCLX4bguM/N7y93zNk=;
        b=rerB5xtGXF7vK28YN/3AEAFi6H4gTnSTxcL+uCJ30Ze/+JnJPre9cqYDoY/T+4KHZz
         GPYIYVfe7k7m5xcKB5RqBO/rbDHTq81KgRfa4mYC3uJlg+N0lbvNSKSXiSMUVTym4Mic
         Sv6QvzXD3/KgZBIJYl8E6jIPwilsaEIqTIy+Oso4JP9/joZ5t4pOt+tYcfwV95sNSdfQ
         6yotvasbcJc1f75GZBWv5DQuMXk/3quGWItrbHGY4ocd35SAEKCqXuT2Xnmy6I/OEOt7
         tc0feklnrT4qnsa/tcuSjRpegGGAe8/gp4NhDjpRyGfWbn1/JGwyVobFXNWqgB9Ypos6
         Dz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhCLpLFtINueWxzzt4Ji/MumhbCLX4bguM/N7y93zNk=;
        b=hdk7iOyI1Y3BtuxtkGpZiA5jy4DYhP3LZC3Ww9C3yFMdg8jUcBHp6xSoAkzSEWOmpn
         mlyy/7ZE5jO5Heu8dvAqwcX/8H10XAeDSv8cN//tiT9BNNgHT6qV0V78TnmrHgMSkaGa
         BOvfrREVKlPa3Nefkr+4y0SjG/sYivAADby7byjMMYd8O2OSHHt1zIBPFlt8n38EAX5+
         loQBGLEMzrqNxUSimKLN2u9Cee/QNYTr5Lf2foqtG7rUuIdtBCvzA8PEqyOhXW5h5rJG
         ROyeEKsuWXxid3+UkYxqXDYBKCfDat/b88mH6w8SRBNQLmqrydvLXKZYBAGdV/8iDdrC
         aLGw==
X-Gm-Message-State: AOAM532XtxlexvTgviF7Q70ZhNUiFzZWNKAjgdDWzOdznrtNKh8DAjmi
        1Pi7udl69nRbhpMtdnq0fIE=
X-Google-Smtp-Source: ABdhPJx6Ok9nx+3JSFyjkEnhVLkFv1utXCh7HNpMjlGpIwP9MiwmkV008M1LGNjVuk37vAvAyS7kcw==
X-Received: by 2002:a50:ba84:: with SMTP id x4mr729929ede.282.1596139597767;
        Thu, 30 Jul 2020 13:06:37 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:ac45:7ad7:8f03:534f])
        by smtp.gmail.com with ESMTPSA id z25sm7158779ejd.38.2020.07.30.13.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:06:37 -0700 (PDT)
Date:   Thu, 30 Jul 2020 22:06:36 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     linux-sparse@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v1] sindex: allow indexing outside the project tree
Message-ID: <20200730200636.axihcb36kkdhzsn6@ltop.local>
References: <20200730132033.613554-1-gladkov.alexey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730132033.613554-1-gladkov.alexey@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Jul 30, 2020 at 03:20:33PM +0200, Alexey Gladkov wrote:
> One possible way to compile the linux kernel is by using the O=<DIR>
> parameter to place all generated files outside the source tree.
> 
> Prior to this patch, sindex filters processed sources to exclude system
> files. The base directory of the project was the current directory.
> 
> When compiled outside of the source tree, this may not be the case.
> This patch adds a parameter and an environment variable to specify
> the source tree.
> 
> You can use it like this:
> 
> $ make O=$PWD-build C=2 CHECK="sindex -B $PWD add --"
> 
> This parameter is also needed for searching if you want to display
> the source code line because sindex does not store lines in the database
> but reads them from source files.

Thanks. Applied & pushed.

-- Luc 

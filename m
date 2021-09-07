Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2941C433F5
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Sep 2021 06:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA9CC61101
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Sep 2021 06:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhIGGQH (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Sep 2021 02:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhIGGQH (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Sep 2021 02:16:07 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F6EC061575
        for <linux-sparse@vger.kernel.org>; Mon,  6 Sep 2021 23:15:01 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n27so17509791eja.5
        for <linux-sparse@vger.kernel.org>; Mon, 06 Sep 2021 23:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RriLPh3XKiDJH3euVT15JG0vcJ5b+eTsO4q9ksWN3wY=;
        b=ZmO4WR6JASDn2xtKoGg6XwFbzzAqJpkI7DZpqvUbhimh9x+ybegQfcU31Zg/iIXcKF
         xvRIXoUs97F9Spf09IEMQHwri6wilQcda+opzUSM7CrCA2a3BfjYZPlq8IpvSLQ+4d14
         jIk9SC9XRAT9fnTt16E2GjfTE1iyk0O8RmT+6AXHlQ2oPKeiNZ7ORPI0gXN4wlprluID
         yNjWDNhY3Bc4JYnxxK7PCPfmnBCEg24YNmrh6+bl56vsDNEVuRAaNCh3VYIIM+RGZf4f
         P6MspJR1ZRhALr5EEX+uCzzpamb0Khb2fjx9Z93wLL5rDKTLn/nQkJWwY/Y52yQsEjcD
         APyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RriLPh3XKiDJH3euVT15JG0vcJ5b+eTsO4q9ksWN3wY=;
        b=Ccl+OtBEL8qs0ijBRRNTvlJXz2cgr+3nQeDWg+rYfif7tucIZsnBeM5CdB4NcUtFCJ
         JEOVUhEhAZPLR0kxCOkjJdp1P16+MngK6XhIKy4RFJsBRaO239C8m4LdIEAntjozqbS6
         NC5viNOs7EG6C+J7Y9Nv1xl0X+DROTkXCO5jsyvRNj53ctU7D0cUFPM6v6o+pCshCYQK
         mwZmf3atV9SghNPRyRc/h8/R2V8Bh1+O8q0FaMCLbEVcfXvi5KUFwi/ACsbyI+zFW46j
         MQ0cUQKxDLnzn09XVNBCFJ0/6tzNBUzJ5ZklEnT+ILneji1PAcIFivdFGj50uSTj0NUt
         0KpQ==
X-Gm-Message-State: AOAM532DOAs3RLDi1tf9BOdpsJdmkU4pyQxlN+/AjlVUgGlythkK48TG
        VPagoh9wFVaFUkS9gHevD/u8uGewK+Y=
X-Google-Smtp-Source: ABdhPJzzSQrDE7Ir2xzQ3KwBLnBNFeLtunuKeMtxsFyCcPZ7fU44fbhwWU9YwoPDfw5rav8PmmNHJA==
X-Received: by 2002:a17:906:304e:: with SMTP id d14mr14333002ejd.170.1630995299833;
        Mon, 06 Sep 2021 23:14:59 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:6d64:8b57:17a6:ebc0])
        by smtp.gmail.com with ESMTPSA id h30sm5867057edz.40.2021.09.06.23.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 23:14:59 -0700 (PDT)
Date:   Tue, 7 Sep 2021 08:14:57 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: sparse v0.6.4
Message-ID: <20210907061457.gqeaq5sy7vz2ukxz@mail>
References: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e9edc9f5-9b88-4a6a-17f8-544270ec2450@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Sep 06, 2021 at 07:53:19PM +0100, Ramsay Jones wrote:
> 
> Hi Luc,
> 
> I have tested the new release, without issue, in the normal way on the
> usual platforms (32- & 64-bit Linux, 64-bit cygwin).

Nice. Thank you.
 
> [Have you posted to the sparse mailing-list yet? I think my subscription
> has lapsed or something! I recently had to re-subscribe to the git
> mailing-list as well. :( ]

Yes, it was posted on the ML (archived as
https://lore.kernel.org/linux-sparse/20210906042111.lhoq7egtpmw3jcv6@mail/ )
I used to be unsubscribed from various kernel.org mailing list relatively
often (but I think I haven't been the last 2 years or so, at least from the
sparse ML).

> 
> Sorry for being tardy, but about 3 months ago a sparse issue came up on
> the git mailing-list (see [1]). Take a look at this:
> 
>   $ cat -n junk.c
>        1	
>        2	static void func(int x)
>        3	{
>        4		switch (x) {
>        5			default:
>        6		}
>        7	}
>   $ sparse junk.c
>   junk.c:6:9: error: Expected ; at end of statement
>   junk.c:6:9: error: got }
>   junk.c:8:0: error: Expected } at end of compound statement
>   junk.c:8:0: error: got end-of-input
>   junk.c:8:0: error: Expected } at end of function
>   junk.c:8:0: error: got end-of-input
>   $ 
> 
> Note: a case label that doesn't label a statement is not valid C, so what
> is the problem? Well, for me, the implication of the email exchange was
> that gcc seems to accept it without problem, except (with gcc 9.3.0):
> 
>   $ gcc junk.c
>   junk.c: In function ‘func’:
>   junk.c:5:3: error: label at end of compound statement
>       5 |   default:
>         |   ^~~~~~~
>   $ 
> 
> ... it doesn't for me!
> 
> So, I decided just to improve the error message issued by sparse. However,
> that caused a moment of deja vu for me - hadn't you already fixed this
> same issue? Having found your commit 0d6bb7e1 ("handle more graciously
> labels with no statement", 2020-10-26), I realized that your fix only applied
> for regular labels.

I vaguely remember there was some complications for switch labels but I can't
remember the details.

> The attached patch was the result of extending your
> solution to case labels, like so:
> 
>   $ ./sparse junk.c
>   junk.c:6:9: warning: statement expected after case label
>   $ 
> 
> Note, just like your earlier commit, this issues a warning, rather than an
> error (which it should probably be).

I tend more and more to use errors only for the cases where Sparse can't
handle the following correctly anymore.

> I wrote this patch back in June, and
> then forgot about it. :( [well, it was only lightly tested (testsuite and
> one run over git), no tests, no commit message and it should probably be
> an error!]
> 
> About a month ago, I noticed that gcc 11.2 had been released and the
> release notes mentioned "Labels may appear before declarations and at the
> end of a compound statement."  This, in turn, caused me to check my
> current draft C2x document (dated December 11, 2020), which includes the
> following:'N2508 Free Positioning of Labels Inside Compound Statements'.
> 
> It just so happens that, last night, I updated my cygwin installation and
> the version of gcc went from 10.2 to 11.2. I think you can probably guess
> what comes next:
> 
>   $ gcc -c junk.c
>   $
> 
>   $ gcc -c -pedantic junk.c
>   junk.c: In function ‘func’:
>   junk.c:5:17: warning: label at end of compound statement [-Wpedantic]
>       5 |                 default:
>         |                 ^~~~~~~
>   $ 
> 
> [Note: I tried several -std=cxx, but none of them even warned without
> -pedantic]
> 
> So, for now, the standard does not allow these constructs, but the next
> standard (whenever that will be) will.

Yes, I'm aware of this but IIRC the motivation was related to the mixing
of statements and declarations. The next standard is planned for 2023,
meanwhile I don't have a strong opinion about this error/warning (but
I'm very fine making things coherent between switch and regular labels).

Best regards,
-- Luc

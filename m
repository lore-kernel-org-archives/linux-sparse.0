Return-Path: <SRS0=5g4H=CP=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F5EC433E2
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8446D20760
	for <linux-sparse@archiver.kernel.org>; Sun,  6 Sep 2020 21:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6VFDg0R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgIFVPm (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sun, 6 Sep 2020 17:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbgIFVPj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 6 Sep 2020 17:15:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05BEC061573
        for <linux-sparse@vger.kernel.org>; Sun,  6 Sep 2020 14:15:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id w1so10859975edr.3
        for <linux-sparse@vger.kernel.org>; Sun, 06 Sep 2020 14:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HV7TZdG4Brw4N/SYs1Tn2Q6PDgeRg4gvE+XSRZ7PIp0=;
        b=f6VFDg0R5xy3TZs3/t+Q2+Sawq3b0lsL1D1UVbIzgqb5Oy3OjYIMepXdaCG/Y2nfao
         PvP0n1kYbkaBqv3P3EWwJW4Ey5mtelaRtRqOn3eRoPkphavsjevfYHbysfepqW7wU8qy
         ELShTe5AMwSYq+9sVi4NzrxVvC4zbN46EdSFZf8XIiKDcwKvhiRGka6N7Lg2MVbpLmwE
         eRZjLmIQ8XyuyQGDDQRgcJEFV8EG1AVqqgppQdVcr3UWHFzzs8vnRlOvC+aBZeu8NIlb
         wipu29m5eno7Gq9bxjFlDxFudzsUllEvtVbN7Fl+EVnxEAZgkJ4BS5GDv+r0LuihdDNx
         3yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HV7TZdG4Brw4N/SYs1Tn2Q6PDgeRg4gvE+XSRZ7PIp0=;
        b=uAcDbol0UkfiH0cHapSm6ZZNQUzxoWON4bepNKnJglaSOyxkoQ5Fk9Cui0IGJ8QI0q
         ljBSAAPGLDSiIVIizm9rXDreBOiT+/Ozj0XxF3/57/N1ig4UUk6J2BVhgOD4ejdcD942
         a6Qlhoh3E/3m8h7vJgESTR/0mn1Cubu85gQCpccDjpR/rJQiK4iBSXY40B/8hf5CS+24
         bmd0tQFO7H/XBRSK0WtmsWFwMItTKFa4JGlhujoAPFTnFqJV59RDEkRZ6TjQKDwy3hKd
         5nItBZ3Qkq5mh5dhiOQPYuYHDvm4DrWKQSxOjxXL/XbGCOdSIl08MglTuwmLPzJm0TGE
         rtcg==
X-Gm-Message-State: AOAM532NIFI0utJflEUb0hqv/ahxBlQ9VGYaCdfugT0WcjjlVl+VS7+r
        eGyp4TnPrjL1dsOyQ/bKAtiOyIEDR6s=
X-Google-Smtp-Source: ABdhPJwaPfLbJWOtSmuY0rfvvZ/krMajNgUFQBApHIXZA2fYmmC2J8qy3zGAAdB+maHV19wlQ1oohQ==
X-Received: by 2002:a50:bb26:: with SMTP id y35mr19651969ede.234.1599426935497;
        Sun, 06 Sep 2020 14:15:35 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:1c0f:34d8:de78:ecc0])
        by smtp.gmail.com with ESMTPSA id i3sm12776126edn.55.2020.09.06.14.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 14:15:34 -0700 (PDT)
Date:   Sun, 6 Sep 2020 23:15:34 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 2/3] add more testcases for AND/OR simplification
Message-ID: <20200906211534.wtbedsju2rdo22j6@ltop.local>
References: <20200906124038.46786-1-luc.vanoostenryck@gmail.com>
 <20200906124038.46786-3-luc.vanoostenryck@gmail.com>
 <bd752e76-f71a-699a-7253-631bd9d4c090@ramsayjones.plus.com>
 <20200906191045.4vgg52mbzlsq5i4a@ltop.local>
 <a845a6af-39bc-c936-0e0c-401025960ac6@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a845a6af-39bc-c936-0e0c-401025960ac6@ramsayjones.plus.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sun, Sep 06, 2020 at 09:12:21PM +0100, Ramsay Jones wrote:
> 
> 
> On 06/09/2020 20:10, Luc Van Oostenryck wrote:
> > On Sun, Sep 06, 2020 at 05:38:54PM +0100, Ramsay Jones wrote:
> >> On 06/09/2020 13:40, Luc Van Oostenryck wrote:
> 
> >> Hmm, I can't see an optimization for these two! :(
> >> Care to explain just what you expect? (maybe with an
> >> '*.expected' file?)
> > 
> > I saw your other email about it but I just would like to add
> > these sort of tests should really be read at the IR level,
> > the output of 'test-linearize $file.c'. Sometimes, the C file
> > is just a convoluted way to create some specific sequence of
> > IR instructions. Also, often the name of the file and the
> 
> Yeah, indeed - which is kinda why I would have liked to see
> an '*.expected' file! It is just hard to try looking at the
> C code and imagine the likely optimization opportunities and
> the effect they have on the IR. :-D
> 
> Having said that, I do understand why you would rather not do
> that. It just makes reviewing such patches a hard job, requiring

Yes, sorry. I realized this only now.

I've added a very small comment with the expected result to
the tests.

-- Luc

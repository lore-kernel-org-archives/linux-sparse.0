Return-Path: <SRS0=NWui=DH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B1C4741F
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9876F206F4
	for <linux-sparse@archiver.kernel.org>; Wed, 30 Sep 2020 23:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsNnY1dl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgI3X2T (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 30 Sep 2020 19:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730597AbgI3X2N (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 30 Sep 2020 19:28:13 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DADC061755
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:28:12 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l15so1015787wmh.1
        for <linux-sparse@vger.kernel.org>; Wed, 30 Sep 2020 16:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uUdTBYfnrOkmx0TquV5eqfAmYbuOjuVHTzR5w09gLJI=;
        b=hsNnY1dlfVNIHFHgCjMkN/4TfjyRssycQbxltQK5oAv0YKkRxvcdLYfsh3YK3ZoYhi
         /Z7rROPobBbSfXs7Xud4eiYwMIj1rkV0bruFI+4XmwwViR3FYMmnynGEVs8O7ibXEQ/L
         MLqTuhG+JN9qGKhYB/pY7z6Ddv0LLfxM3kq4SGv08AZhLArcTL41hZB67vFwPa2AyQpU
         xrqZiQKDOu1Q3f3UnbEjAbpvtaqekrfHnITLazpz6PGPsXgeYt3BdfhsuNmtVFVyAaKi
         DSH5GlMHMsrd9jlDqSg+L5aavXgzgGS1/uyTafeffsqL+4LTGKF/w89I/CZOwK/3xX2K
         xwUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uUdTBYfnrOkmx0TquV5eqfAmYbuOjuVHTzR5w09gLJI=;
        b=Lt4J4sriDCOlgPNli744GP+EmGhTn5/KyfZ4KVwXUs6Um0K7YXzJsmJd7BMZ8CHjKg
         +/3X2Rchst6Tw9+LvVWluLhsmgRZ8bap+AH2hKhMs9cuZgPIjXci9RBukEpAFbZXCOCc
         Hw8fblzALzbQDLtu7x5mu9etzhvzKxkB3lxiqgeYX8Y8psTmNU2BqriO9bY5w3LRkfh9
         U7/nbffVX0Bbc6l3UZmKkayZOvmosEssqIEZ1dWg2GriKYrMoXj/n7l4i01WyHj7WZA0
         ptTyl6UXvc5dDA//jtHGp3q5OSKVIe/u9JLPaGJ0NkKX11fsOWlR8TtMBIyLNZoxbCUl
         oE5Q==
X-Gm-Message-State: AOAM532rN67+nW+WYucUhvBZFhj/G1ipEYcvSLZxtmST7rJs/X5MpfNj
        eSylAkwO7ykrySd9H23Fq2K1w5TV+/M=
X-Google-Smtp-Source: ABdhPJzfTSU8gPgwCyGmPneHiTj2rtYfD3ItUnvhxaUev3dtfNi6Qy0wtOEWKm1fmDK3YEcBeOc38A==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr5011263wmk.29.1601508491522;
        Wed, 30 Sep 2020 16:28:11 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:d0c8:dbcc:51b0:75b9])
        by smtp.gmail.com with ESMTPSA id y1sm5506093wmi.36.2020.09.30.16.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 16:28:11 -0700 (PDT)
Date:   Thu, 1 Oct 2020 01:28:09 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Subject: Re: Making structs with variable-sized arrays unsized?
Message-ID: <20200930232809.soika2g32ddo6doh@ltop.local>
References: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
 <20200918204149.eqpl352wygwem34a@ltop.local>
 <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgnWnk6H376pux0V13Re6Gb6sFhqsS2oSW6E_v5CyfChQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Fri, Sep 18, 2020 at 01:49:46PM -0700, Linus Torvalds wrote:
> On Fri, Sep 18, 2020 at 1:41 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > I also have 2 questions here under.
> >
> > >     struct bad {
> > >         unsigned long long a;
> > >         char b[];
> > >     };
> > ...
> > >     // The layout is odd
> > >     // The code does "info->align_size = 0" for unsized arrays, but it
> > > still works?
> > >     int odd(struct bad *a)
> > >     {
> > >         return __alignof__(*a);
> > >     }
> >
> > This returns 8. What's odd here?
> 
> The fact that it works correctly.

For info, it was just a coincidence. The returned value correspond
to the value 'max_align' which was not reset. This is now fixed in
the series I just posted.

Best regards,
-- Luc

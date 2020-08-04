Return-Path: <SRS0=xnzy=BO=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CE9C433E0
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 19:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7E821744
	for <linux-sparse@archiver.kernel.org>; Tue,  4 Aug 2020 19:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0ikKt6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgHDTdW (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727911AbgHDTdU (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 4 Aug 2020 15:33:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AACC06174A
        for <linux-sparse@vger.kernel.org>; Tue,  4 Aug 2020 12:33:20 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id q4so27513922edv.13
        for <linux-sparse@vger.kernel.org>; Tue, 04 Aug 2020 12:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vRj9uLy4yeNlP4jGlxk/OOg9ZzIoE/oKg2E1fvxjIls=;
        b=f0ikKt6HN7h5S9s5QX08QnE/+bECIFqVncK4btrhk8lSi2apctk+x05kbc52IREtKd
         11vaYDST2bWnPLqqwfYdC+v/bSe6T6oe1kfKW4JvGuTWpbvQowyXyFl1zg/IXvLEo3+v
         Mytkg7qoHRBrdoQNN3E2xcWdCxBuKUQmycQ+1CK9mxapAy2PTKlZ75TX4EKNBhWt0oec
         c9Y00ELdC7CkQVQqiCOUp7nttF6uKPlfljziduuidli+EjZ0nD4Z9gG1aH8Ov5Pj9jT2
         7lz1EHJxuAjP85iDPQstI7+E2D3byUeA4JDin55ebpddhRTpFhAfs9AprP2SzUjw4w+D
         cPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vRj9uLy4yeNlP4jGlxk/OOg9ZzIoE/oKg2E1fvxjIls=;
        b=g0VhaQwCvW97vtpEztiLJ+9QY50h32c+XPbrvtsGnHhWeaepyJEAzNZas30nuQkiig
         lt5m5FA7Q8kpCkJ2ZN82VAo7pVbJdKNdttgYKotQfwfQMa1pfKyY0BEk1HORN7enaave
         I//MvDKcRZ9ZHicWvw1OppKi4rm0ten+4YvN+iZjoaVPKHFUL1FDfoFkeXQtfULh73fd
         XMPcYJ1ma/6anrN02doUMxQvaxG1rgbJ3t55iovkTX7qB4/UbVQRvIDPOj/OnS8leIt7
         7oCxcTJwkNPzH8RWPkk+JdnGvsbZPD41QgEFJFBDVQj1aR+R1nNhKqDgQZ31dhorI5oH
         luvQ==
X-Gm-Message-State: AOAM530kthsD7suiVrrRJ8XG8dVOjcmfOPCeJ9jcS4/Kn7DWBdbbDq7G
        eDz1nCMK26RNYSQSKRuGme4=
X-Google-Smtp-Source: ABdhPJx5bov1NKedYLoEcrf6D9rwjLEBOSyg2KLqDeQ5MdDxkNWzHrHCi7oar21vSgpc9tIvDHkn+Q==
X-Received: by 2002:aa7:d607:: with SMTP id c7mr21868830edr.184.1596569598902;
        Tue, 04 Aug 2020 12:33:18 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d068:a44f:fa3b:62da])
        by smtp.gmail.com with ESMTPSA id x20sm19316697edl.8.2020.08.04.12.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 12:33:17 -0700 (PDT)
Date:   Tue, 4 Aug 2020 21:33:16 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Alexey Gladkov <gladkov.alexey@gmail.com>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= / sparse 
        <gitlab+9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>,
        linux-sparse@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>
Subject: Re: sparse | upgrade to upstream v0.6.2 (!2)
Message-ID: <20200804193316.k6ofbo3l77nfit4z@ltop.local>
References: <reply-9b7df497d06cab14c2bf3c1022d8ca15@salsa.debian.org>
 <merge_request_28506@salsa.debian.org>
 <note_185002@salsa.debian.org>
 <note_185155@salsa.debian.org>
 <20200802213035.w7bexg4zdusr25xf@ltop.local>
 <20200803145308.o2y4mln5fzlgdr4v@comp-core-i7-2640m-0182e6>
 <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200804163812.l2njaeyo7fcsbogt@comp-core-i7-2640m-0182e6>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Aug 04, 2020 at 06:38:12PM +0200, Alexey Gladkov wrote:
> On Mon, Aug 03, 2020 at 04:53:10PM +0200, Alexey Gladkov wrote:
> > On Sun, Aug 02, 2020 at 11:30:35PM +0200, Luc Van Oostenryck wrote:
> > > On Sun, Aug 02, 2020 at 08:18:42PM +0000, Uwe Kleine-König wrote:
> > > > Uwe Kleine-König commented on a discussion: https://salsa.debian.org/ukleinek/sparse/-/merge_requests/2#note_185155
> > > > 
> > > > There is still another issue that popped up in the meantime: 
> > > > https://bugs.debian.org/966706
> > > 
> > > Hmmm, I think that a corner of my mind was silently worried it
> > > will happen.
> > > 
> > > > The options are:
> > > > 
> > > >  - add a Conflicts: biosquid
> > > >    (this is the ugliest option)
> > > >  - rename sindex to something else
> > > >  - convince the bioquid people to rename their sindex
> > > >  - stop shipping sindex
> > > > 
> > > > For now I will go for "stop shipping sindex", do you have an opinion for a long-term plan?
> > > 
> > > [+CC to sindex's author]
> > > 
> > > Not really.
> > > Would it be easy to install it under the name 'sparse-sindex' or
> > > 'sparse-index'?
> > > 
> > > One thing I would like (in some future release) is to split
> > > the sparse package at least in 2:
> > > * one with sparse itself
> > >   - it has no dependencies (except the libc, a compiler compatible
> > >     with gcc and GNU make for the build)
> > >   - maybe cgcc should be included in the package too (which would
> > >     add a dependency on perl)
> > > * one with the others tools
> > >   - but maybe it would even be better to the big ones in their
> > >     own packages with their own dependencies)
> > > But this would not really solve the problem here.
> > 
> > Renaming of sindex was an option for me, but since you have a plan
> > to split the package anyway, then I think it's better to do so. I tried to
> > use the libsparse.a and it looks like it works fine [1].
> > 
> > I spoke with Oleg Nesterov and he also does not mind moving this utility
> > to a separate repository.
> > 
> > [1] https://github.com/legionus/sindex
> 
> Oleg pointed out to me that my email is not entirely clear :)
> 
> My email does not mean at all that I moved the utility to a separate
> repository. I made a proof-of-concept.
> 
> Don't get me wrong, I don't mind renaming the utility. This is a good
> short term solution but to be honest I don't like the name 'sparse-sindex'
> because it is very long. Can we think of something shorter ?
> 
> Also, could you tell us more about your plan for future releases ?
> How do you plan to split the repository ?

Ah sorry, it's just a misunderstanding. The context of my email wasn't
very clear. But no worries, I have absolutely no intentions to split
the repository (that would be very annoying for everybody). I was only
talking about, maybe, in some future, split the *package* at distro
level. For example, currently Debian has already 2 packages for sparse:
one, called 'sparse', with almost everything, and another one only
with 'test-inspect', called 'sparse-test-inspect'.

In any case, I don't have any precise plan, and distro packaging is
anyway something to be decided by the distros. So, if anything will
done in this direction, it will be done in collaboration of the distros
and anyone involved.

For the name, I'm also don't like 'sparse-sindex', but it would just
have been an easy way to avoid the name conflict in Debian packages
(I understand that no such conflict exist with Fedora because
'biosquid' only exists for Debian).

Best regards,
-- Luc

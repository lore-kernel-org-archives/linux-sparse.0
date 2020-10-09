Return-Path: <SRS0=CK19=DQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB638C433E7
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CAC22261
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOsWtxI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389252AbgJIPj4 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbgJIPj4 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Oct 2020 11:39:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF77DC0613D2
        for <linux-sparse@vger.kernel.org>; Fri,  9 Oct 2020 08:39:55 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so13738086ejg.1
        for <linux-sparse@vger.kernel.org>; Fri, 09 Oct 2020 08:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ePDcs/S+sw9Y6yJUGxvr63g6HxvNELMwCOzhHTweXjk=;
        b=JOsWtxI35LUZZ6xBxj7jozwCLcJ/IzeqFetXkGL/dJ5kSnHWZ76B7nOnRNSiUeQHbc
         qAMyJrvZ7GawEi4GkcDMtny3NFqVISwdcb1ipLid2Ebxs/SI6HJUaQj5MLZtMaJG88mZ
         1ZelwhTDccZ9SPBOppI3Zy+isHQCJTjIoAflpi5mmyijcOSwrMNvHS8M6c9zd8y+Sxmz
         s+uddSzTfpBtNA+77R2zWo22MJLs037fRFmcb4fp+rHwKD9qMu7kXxzMg+bPYxbECx/l
         Mxo2Wc0bBXuSMXfTVc1AcTTKBczy4nODwF39+SkoFSKSYsBBYcHYeJLl5ctO8oucTd6P
         b6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ePDcs/S+sw9Y6yJUGxvr63g6HxvNELMwCOzhHTweXjk=;
        b=SQaFS7AbOu0IihK1aX2wPKO1u5jKcQVqCJWBTbwSgCItE3CGXKpfPPK3RNPJ8hLjk/
         m9D2+EdMbGj1qYaqCwnEbRrV2r1W8+BmZKGg4GnExAcrmZmUZu1+K3XU9WXwlhxXPTRd
         RkpvY57dTSvbF01ttml+iP/m1hphHusRwdGsXtmFpsKphrjGDGxuEK0zJOnz6k3Vxp4L
         9Ih1Qz/SPJNqNHdAia4iapSolbZKi27LJ3GIG6MceWW+38cKu5z4mN6Fpc6Czk45Gqql
         vW+L8JEzIsjZnXTDIYGfDMqztdb93yMheyV/8aHIBMKT3CjSsmfdM5en7MKoWbs0Y2G6
         xHgw==
X-Gm-Message-State: AOAM532gwjjg4FHqq4JnuTg8L/dc4UhKYMLuTVg59ZEy0bePL+cFvOmA
        DAyJNer3CsttVFds4tTOZ5A=
X-Google-Smtp-Source: ABdhPJztudUrExNEo8znh9OGxsXlonbZxzImjzRWuMHICO3Yvn79llOz65LI7GzcTKRPJAqv2TEPbQ==
X-Received: by 2002:a17:906:d045:: with SMTP id bo5mr14270055ejb.320.1602257994392;
        Fri, 09 Oct 2020 08:39:54 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b916:75c5:e328:ad7c])
        by smtp.gmail.com with ESMTPSA id h10sm6509900ejt.93.2020.10.09.08.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 08:39:53 -0700 (PDT)
Date:   Fri, 9 Oct 2020 17:39:52 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
Message-ID: <20201009153952.io6hdo4srfc653z5@ltop.local>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
 <20201007230920.lsclffcffqeywpev@ltop.local>
 <c1d215cc-b498-c48f-dc91-b98ad0627c2d@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d215cc-b498-c48f-dc91-b98ad0627c2d@ovn.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 08, 2020 at 08:36:02AM +0200, Ilya Maximets wrote:
> On 10/8/20 1:09 AM, Luc Van Oostenryck wrote:
> > On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
> >> There is a common pattern on how to allocate memory for a flexible-size
> >> structure, e.g.
> >>
> >>   union {
> >>       struct flex f;  /* Structure that contains a flexible array. */
> >>       char buf[MAX_SIZE];  /* Memeory buffer for structure 'flex' and
> >>                               its flexible array. */
> >>   };
> >>
> >> There is another exmaple of such thing in CMSG manpage with the
> >> alignment purposes:
> >>
> >>   union {         /* Ancillary data buffer, wrapped in a union
> >>                      in order to ensure it is suitably aligned */
> >>       char buf[CMSG_SPACE(sizeof(myfds))];
> >>       struct cmsghdr align;
> >>   } u;
> >>
> >> Such unions could form an array in case user wants multiple
> >> instances of them.  For example, if you want receive up to
> >> 32 network packets via recvmmsg(), you will need 32 unions like 'u'.
> >> Open vSwitch does exactly that and fails the check.
> >>
> >> Disabling this check by default for unions.  Adding new option
> >> -Wflex-union-array to enable it back.  This option works only
> >> if -Wflex-array-array enabled (which is default behavior).
> >>
> >> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >> ---
> >>
> >> Not sure if this is a best way to fix the issue, but it works fine for
> >> openvswitch project. The actual code in question that makes sparse fail
> >> OVS build could be found here:
> >>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238
> > 
> > This fixes your problem for -Wflexible-array-array but the same
> > will happen with -Wflexible-array-sizeof (and you're using sizeof()
> > on such flexible unions) and -Wflexible-array-nested.
> 
> I thought that it will fail some other checks too, but for some reason
> it doesn't.  But, yes, you're right, It sounds safer to disable all
> of them to avoid possible issues in the future since we're actually
> using these unions.

Thanks for giving it a try.

> >  options.c                         |  2 ++
> >  options.h                         |  1 +
> >  sparse.1                          |  9 +++++++++
> >  symbol.c                          |  2 +-
> >  validation/flex-union-array-no.c  |  9 +++++++++
> >  validation/flex-union-array-yes.c | 11 +++++++++++
> >  validation/flex-union-array.h     | 11 +++++++++++
> >  7 files changed, 44 insertions(+), 1 deletion(-)
> >  create mode 100644 validation/flex-union-array-no.c
> >  create mode 100644 validation/flex-union-array-yes.c
> >  create mode 100644 validation/flex-union-array.h
> 
> Since you renamed the option, it might make sense to rename
> files to 'flex-array-union...'.

Well yes, I left them more or less on purpose but renamed them now.

-- Luc 

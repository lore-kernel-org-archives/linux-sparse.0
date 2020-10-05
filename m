Return-Path: <SRS0=4is7=DM=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 351D4C4363A
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA39420781
	for <linux-sparse@archiver.kernel.org>; Mon,  5 Oct 2020 23:47:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yl8TCiEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgJEXrx (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 5 Oct 2020 19:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgJEXrx (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 5 Oct 2020 19:47:53 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2C7C0613CE
        for <linux-sparse@vger.kernel.org>; Mon,  5 Oct 2020 16:47:53 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id u8so14763108ejg.1
        for <linux-sparse@vger.kernel.org>; Mon, 05 Oct 2020 16:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xgN+98XncB/aDU6m6N8Ofezi9atrtSf9YBpzvFnicAw=;
        b=Yl8TCiEs+c18nQQ2AQKDWhkYYivbOjWyZh8+OorOjc1uPa3cHi2HSg8vDwvL5xFD8r
         GWEIvI930tR266eZoJXQOdypgFFnFvfBYTGo77FiYfkN2DzRz9Keu9QQZ3A3IoeUdphq
         NsoYL2n7zqOR4TN7MLeCqRjFPdw0vrTlhDVHvlKYJZZbfccKgIRZ/A9xlctS1g6qWfbz
         L36uAb3sjS4Q1NXkfED/aK6Ae4E/hFrV6OOevCvIfmeiP1/5783gqt+0xI4cRA00tYFt
         dkkocA/M0IPHPR9WKXW2ijXpqtatmpFYFdU0TiFmJG+Eym2h6ozIdQlzpGeoIWINCVHM
         5Q+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xgN+98XncB/aDU6m6N8Ofezi9atrtSf9YBpzvFnicAw=;
        b=uTiHwTEq7tjDKGg0wgQ7NJzdLKFT3/eO5SBeTQ32BXfiq+4v6GlwcSQ6a04QnTpdpU
         PJV2XARwydJHlYiAXUky2p1vL1ERTun1mjHr+RU0EZqqjuPeauy1hYyHZYl+HWnpRVR+
         MvXkOZknROoYpkQT60cB/Df35Q6Y0v0yVl5cseTrrafIlokuK4+cREGrnZZvPXcxmr/X
         b8tzjVFgoixKM5uotapCWVSm44XVYESnvxUqAXOsGH+z2j7jHsUP1qdGQWftuVg9BXBh
         uZKZfK90c9ihvyn0Y9IdoFOoURo3EVFBmRx/+4gL+LCpSFPdg95x31HA5vOqsReaYCTm
         K3Cw==
X-Gm-Message-State: AOAM531Us/aivpWWY/LVCCWCUDad4actZg2/JFaexT1t7ZaiQIKCNRPV
        iPyweEPTvKzR8e0Ze2Lgh1k=
X-Google-Smtp-Source: ABdhPJySHOyHky2M1ghz8lT/Dv7Bubn3gYQOEKSWyX7T6nQg93yZEbMj/b1d/hSFY6gpyveTsuQEsw==
X-Received: by 2002:a17:906:131a:: with SMTP id w26mr2307155ejb.271.1601941671770;
        Mon, 05 Oct 2020 16:47:51 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:414e:4652:8edc:a08f])
        by smtp.gmail.com with ESMTPSA id s1sm946956edi.44.2020.10.05.16.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 16:47:50 -0700 (PDT)
Date:   Tue, 6 Oct 2020 01:47:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 0/8] format check tweaks
Message-ID: <20201005234749.dfw34pvgb2uavuko@ltop.local>
References: <20201005020002.1108-1-luc.vanoostenryck@gmail.com>
 <58d771f9-7560-f682-3173-78dea0f83711@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58d771f9-7560-f682-3173-78dea0f83711@codethink.co.uk>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Oct 05, 2020 at 10:04:43AM +0100, Ben Dooks wrote:
> On 05/10/2020 02:59, Luc Van Oostenryck wrote:
> > Ben, these are small changes I think should be applied with
> > your series, on top of the patches I send yesterday.
> > I've pushed everything at:
> > 	git://github.com/lucvoo/sparse-dev.git format-check
> > If you're fine with these, I can squeeze them with the series.
> > 
> > There are also a few tests I don't agree with:
> > 	const void *ptr = ...
> > 	printf("%s", ptr);
> > These tests silently accept this, but they should warn.
> > But this can be fixed at a later step.
> 
> ok, thanks.

Hi,

I've now pushed it on a separate branch on the official tree:
  git://git.kernel.org/pub/scm/devel/sparse/sparse.git format-check

It will thus not be rebased anymore and any changes will need to be
incrementally on top of it.

> I'm going to try and work out the best way to deal with the kernel
> extra funsies. I have a few ideas but yet to make a coherent document
> about them.

Well, the reason I've not yet merged it with the main branch is
because enabling -Wformat creates really a lot of warnings in
the kernel and people definitively use this.

Most of these warnings (if not all) is caused by using
check_assignment_types() which was good as a quick & dirty solution
in the early stages but isn't at all adequate as a true solution
and this for several reasons. I've also begin to take a look at
this with a relatively satisfying result by adopting the following
strategy:
	Since no 'checking' function in evaluate.c has the needed
	characteristics, simplest is to create in verify-format.c
	what is needed.
This also gives the flexibility needed to support things like
-Wformat-signedness.

I add here below only small extract because it's for now quite
messy and need quite a bit of polishing.

-- Luc


enum {
	CLASS_OTHER,
	CLASS_INT,
	CLASS_BITWISE,
	CLASS_FLOAT,
	CLASS_PTR,
};

///
// retrieve a 'type class' for quick testing and extract the base type
static int type_class(struct symbol *type, struct symbol **base)
{
	if (type->type == SYM_NODE)
		type = type->ctype.base_type;
	if (type->type == SYM_ENUM)
		type = type->ctype.base_type;
	*base = type;
	if (type->type == SYM_BASETYPE) {
		struct symbol *kind = type->ctype.base_type;
		if (kind == &int_type)
			return CLASS_INT;
		if (kind == &fp_type)
			return CLASS_FLOAT;
	}
	if (type->type == SYM_PTR)
		return CLASS_PTR;
	if (type->type == SYM_RESTRICT)
		return CLASS_BITWISE;
	return CLASS_OTHER;
}

static const char *printf_fmt_flt(struct format_type *fmt, struct symbol *source)
{
	const char *typediff = "different base types";
	struct symbol *target = fmt->type;
	struct symbol *base;

	if (type_class(source, &base) != CLASS_FLOAT)
		return typediff;
	if (base == target)
		return NULL;
	return typediff;
}

static const char *printf_fmt_string(struct format_type *fmt, struct symbol *source)
{
	const char *typediff = "different base types";
	struct symbol *target = fmt->type;

	examine_pointer_target(target);
	examine_pointer_target(source);

	if (type_class(source, &source) != CLASS_PTR)
		return typediff;
	if (source->ctype.as)
		return "different address spaces";

	// get the base type
	type_class(source->ctype.base_type, &source);
	type_class(source, &source);

	if (target == &const_string_ctype) {
		if (source == &char_ctype)
			return NULL;
		if (source == &uchar_ctype)
			return NULL;
		if (source == &schar_ctype)
			return NULL;
	} if (target == &const_wstring_ctype) {
		if (source == wchar_ctype)
			return NULL;
	}
	return typediff;
}

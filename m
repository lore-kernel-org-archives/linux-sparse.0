Return-Path: <SRS0=zxAK=BH=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FAC433E0
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 23:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 380132074F
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Jul 2020 23:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq4lAx21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgG1XLD (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729654AbgG1XLC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Jul 2020 19:11:02 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F94C061794
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2020 16:11:02 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c16so1962989ejx.12
        for <linux-sparse@vger.kernel.org>; Tue, 28 Jul 2020 16:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qM/etghxYezbiGaChzDWipJ4XCJyz7oT6Lt6x+okX7o=;
        b=Iq4lAx21Ap0NVhdUMBdgBS7PuzoHh1ZCoR/xfnGYXyn16p75xgip/K9p4HONgl8t7r
         UvuW1MwJh9GLLX/JmS19Q5YknhSoSzJ9HrAQ8yVQQCEppDSjlraSvmIRIOrB4n3oScCl
         Hnmo1qPmCSJJqpQ8jmjYoaGaanIljhXtCp+9zYAujytWP8EFtSKO50B+fPGYhPvOtn1x
         s7eFvv57FdUNLxLaQewVaxJg+IBYxtRownuXkSl5siTGxFYoflkIRtQqTobMlyyp1+Pb
         nzLTo/8HxRaHdSJUFIPSEs7XZ2SZqz53qFY6mSATnIoV4DQJ+CwH+xtedLKe/RmyRoby
         n7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qM/etghxYezbiGaChzDWipJ4XCJyz7oT6Lt6x+okX7o=;
        b=is+Aiv67smFcbLiQjjxjupEpRUV8Dx1I6dB0Pjw2vskDPzBxM5COjQQjbrzgmTQMqe
         BLd8GAVGaOGGyWISv0Fb3vbl92qMtQBkVW3gagrSb74TF9Yn/hxNHlZ8jhyE6AY2ccw4
         QGggnm5TOglJfvYhLiFQD/1PaiXb0dUjT83jzIeri+oF7STJxSSqxX+jis/GY76okMtt
         09+NXf9L5xxcvQUNQ9gwts6J5VAu9Jwp7MMLhvV/Q6EILm3+4DRi6nfByEdgY0t/EQQW
         szCRRWgFcUzRLT8Qf5TS36cbAmP6XMoLG3AB1a5txM6z+dhmOuriTs6mkWvBrBnlfVgE
         y0qA==
X-Gm-Message-State: AOAM532mJBP6o44HiOUe76lDJmTsShU3wW9lfKpmCWeG+QJi/CwYG0eE
        1KLLK5S/GrBpmknmRdSapWA=
X-Google-Smtp-Source: ABdhPJwJSTMTnQLjeX7+0ljI0LKrjQbyoLMetJGjnYBdrwNjmTQ5gHvddJ9gtAr62adpihS2QvckhA==
X-Received: by 2002:a17:906:c0d9:: with SMTP id bn25mr27164235ejb.176.1595977861181;
        Tue, 28 Jul 2020 16:11:01 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:e898:a163:5b77:8589])
        by smtp.gmail.com with ESMTPSA id x1sm78372ejv.11.2020.07.28.16.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 16:11:00 -0700 (PDT)
Date:   Wed, 29 Jul 2020 01:10:58 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH] dissect: add support for _Generic
Message-ID: <20200728231058.3yakpfw3dqslxq5t@ltop.local>
References: <20200728183507.422662-1-gladkov.alexey@gmail.com>
 <20200728194937.GA2467@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728194937.GA2467@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jul 28, 2020 at 09:49:38PM +0200, Oleg Nesterov wrote:
> On 07/28, Alexey Gladkov wrote:
> >
> > No special support needed for _Generic,
> 
> Hmm. I am already sleeping and didn't read the _Generic code yet... but
> shouldn't dissect() inspect ->control/map/def?
> 
> That said,
> 
> > so just suppress the warning
> > about unknown type.
> 
> probably better than nothing, lets shut up the warning first.

OK, since there is some urgency, I applied it directly but
my first reaction was also "eh, you can't just ignore
EXPR_GENERIC / pretend it's one of the top-level expression".
OTOH, I wonder what can be done without first evaluating
(the type of) the controlling expression and the types of the map
(if I understand correctly, evaluation is avoided in dissect).

-- Luc

Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3CC3C433DF
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FABA2053B
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMAas76G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbgHOWAj (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbgHOVvf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:35 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5277C02B8D2
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 04:03:27 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id bo3so12501051ejb.11
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 04:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Srh6s7HYKRKFfEnsNaIS80ZpP8rR7XJjsPJDDX7Ifq8=;
        b=vMAas76GhnZGsb+K+NFq5LkKc4xQVbGfi6awa5qAnLVtUbjtNdLL8yq1jtdwBN8nEl
         12D5ZEdvn8QuhEtbCu3FirMqmg5H7Ayni9mbFpHBOVJcdvtxSjC83aYo9WN8TyLLTGY5
         SRukYvQ1k7pmnwXRxXxfcGxRZ+YmBk92Md3Kpd6B1FBYn8a8JpmoBx/kL1dkEV+70MIl
         Al1yDvPYbJvfLPl6kd9gX8RvFJT4n0UKTAE4oqoKL/vDXXHbLpSR2ERLctuO7pyOKRRX
         A3IzS0f+rJ7Cov2Rx72oNQQwNDOTNDTDz/DLZWVlOtUhBA0Nb5EWXBdwGvmXDu487tFN
         PgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Srh6s7HYKRKFfEnsNaIS80ZpP8rR7XJjsPJDDX7Ifq8=;
        b=esnmlM5Euni++2QYNAUsajEfY97K9zT5nAqMfAHZoZy/gQNNEceXYtLtLJCjEDBiFj
         5V7DdpED4mOK3Ur6zarxNw7tSukmOMh/CdDdHA3nG8skzj0PQBvsCvnqObaCeBZ2z4Ul
         88ZrVSqG3M2/VrnyPiyUd05E0xTH3p9FXmdZYHynsKnEdeyvfVedYKBsdxnI03gIBEZg
         baB5I41wYY8Wqv6jakvGQtjTsOBRqauhLb0Jnb84vo9PDmWBav1vzBZ1FftU24Xt6if6
         aUi85e4LmBsOUMlrr8/Zto0kh8VfPFAcAyxtYhmTj5YRcpFZKM0mfcnJHBxUlRWHFcDq
         rR5Q==
X-Gm-Message-State: AOAM530YvyYUqWHlTOQH+yY1V3lETA5G9eTOLod97zqhC04KDt/zveqq
        15m9rpx8xhYBX58pMIx7dQ8=
X-Google-Smtp-Source: ABdhPJzYRZ3ZqY+zP7DNJ8E42VJcFA5KQebWdhM76048ZHxIeSW4YSpm75Tngy6uiCEfoWboH8uoig==
X-Received: by 2002:a17:906:6ad8:: with SMTP id q24mr6436757ejs.192.1597489406458;
        Sat, 15 Aug 2020 04:03:26 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:818c:70d:debe:a811])
        by smtp.gmail.com with ESMTPSA id v20sm8856759ejr.12.2020.08.15.04.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:03:25 -0700 (PDT)
Date:   Sat, 15 Aug 2020 13:03:24 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 0/4] Fix shifts-assigns and avoid warns on deadcode
Message-ID: <20200815110324.j4kvv2brr2lgcxnc@ltop.local>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
 <20200815095949.GV80756@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815095949.GV80756@lianli.shorne-pla.net>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Aug 15, 2020 at 06:59:49PM +0900, Stafford Horne wrote:
> On Thu, Aug 06, 2020 at 09:29:59PM +0200, Luc Van Oostenryck wrote:
> > Sparse warns shifts by a negative or oversized amount but
> > it does this even on code that will not be executed. It's
> > annoying because such warnings are given for generic macros.
> > 
> > The strategy for these warnings is changed in patch 4:
> > they are delayed until after the elimination of deadcode.
> > This uncovered a bug in the type evaluation and the linearization
> > of shift-assigns which is now solved in patch 2 & 3.
> > 
> > Thanks to Stafford Horne to bring this back to my attention.
> > 
> > This series is available for testing & review at:
> >   git://git.kernel.org/pub/scm/devel/sparse/sparse.git bad-shift-equal
> 
> Thanks!
> 
> I see you merged this already, I tested it and see no regressions on my kernel
> build, and confirm the xchg issues are fixed.
> 
> Sorry, I reviewed this early but didn't respond until now as I had time to test.

I should have waited a little more before merging (but OTOH, I thought,
it would be easier for you to give it a try before sending your PR
to Linus if already merged).

-- Luc

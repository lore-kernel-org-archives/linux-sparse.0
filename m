Return-Path: <SRS0=rhKz=BZ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F45C433E3
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13666205CB
	for <linux-sparse@archiver.kernel.org>; Sat, 15 Aug 2020 22:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dY+y3L98"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbgHOVvE (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbgHOVuy (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926CDC02B8FC
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 06:51:23 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id mw10so5598061pjb.2
        for <linux-sparse@vger.kernel.org>; Sat, 15 Aug 2020 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fZYpsiQ1i8xE5OFWkOzLGlFd0ZmFDTUuWWWX9RqOtQA=;
        b=dY+y3L980KwtILClseICtkCIBCOIQb0Vc8Xm48i5k4It3h51JyCNVMjMbDGbykEiKi
         q5V6bueYXjarNdCtpE+W45VLREOA/hhAl88EoTpqBlwGMtW/PjyLARxdpIAFPCnpDmIf
         qbADPgybi/TqeARQ8yPig0Z8TN/Vi+ICuNR45OrpPomQd2iZ3CMh0HHWozti2+d+KAaT
         yBXkoPxmr7UuEsNbNlmgTshHZ3LEL1XK7A0YxObUEawXMYBnKscEb3Oos/VF3BU3trM7
         YPw3NGMcedvdAxow/W8e75wqsVrZScMILambPMNCizdLcNx0641shcsiEEDArAlL5EaG
         aS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fZYpsiQ1i8xE5OFWkOzLGlFd0ZmFDTUuWWWX9RqOtQA=;
        b=gXMvzrV+eDQDC1gPMsu3DcCzjNjH1UIlxpoN5WrAoqZ3kmuKKkXFFpoKVQ3VyPCq4e
         KaaiivMxWY7trm/UtWMROhQvXh/qq2oZ78fna2psv14vLOx5qPtmIG/o8IDGEX4e+uBE
         vQgkmjlmrj/oCTmZNzMNSy1IbveLdfeKPaZ3DPSTBflmeDBGmjCmJZdAim0Nq15Nw+jr
         DvChJQy8COSHH/SiA5LzAn9b33YeyCyhbjH/YgtoPXpgN1wIcBCn1D7ynjP5xFUAfklw
         DyUhMDsjYucFQksle/nHGFMh4dhJybz1gCi3rqP/K+EQMd5K+9xdQDq9vB5VzMx3vAIm
         0VyA==
X-Gm-Message-State: AOAM532LOcVhB8YoK72jkRJVE9hu/ep3gxbcDy/r3QcpzxWqLVvawmyh
        4pDqn+GCZzfjmROAkUvoepM=
X-Google-Smtp-Source: ABdhPJw60NaTVLi2Kaq6nlCdIqy7F4WUEhFiy/ECcS/C7aRB5Xc3mX0iVi/iyAZge0oPTXeDDzi1Mg==
X-Received: by 2002:a17:90a:f28b:: with SMTP id fs11mr6311191pjb.34.1597499482190;
        Sat, 15 Aug 2020 06:51:22 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id m15sm6878062pgr.2.2020.08.15.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 06:51:21 -0700 (PDT)
Date:   Sat, 15 Aug 2020 22:51:19 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 4/4] bad-shift: wait dead code elimination to warn about
 bad shifts
Message-ID: <20200815135119.GW80756@lianli.shorne-pla.net>
References: <20200806193003.10144-1-luc.vanoostenryck@gmail.com>
 <20200806193003.10144-5-luc.vanoostenryck@gmail.com>
 <20200815095703.GU80756@lianli.shorne-pla.net>
 <20200815111540.nxdsfzurv555qpap@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815111540.nxdsfzurv555qpap@ltop.local>
Sender: linux-sparse-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Aug 15, 2020 at 01:15:40PM +0200, Luc Van Oostenryck wrote:
> On Sat, Aug 15, 2020 at 06:57:03PM +0900, Stafford Horne wrote:
> > On Thu, Aug 06, 2020 at 09:30:03PM +0200, Luc Van Oostenryck wrote:
> > > --- a/linearize.c
> > > +++ b/linearize.c
> > > @@ -2468,6 +2468,49 @@ static pseudo_t linearize_statement(struct entrypoint *ep, struct statement *stm
> > >  	return VOID;
> > >  }
> > >  
> > > +static void check_tainted_insn(struct instruction *insn)
> > > +{
> > > +	unsigned long long uval;
> > > +	long long sval;
> > > +	pseudo_t src2;
> > > +
> > > +	switch (insn->opcode) {
> > > +	case OP_DIVU: case OP_DIVS:
> > > +	case OP_MODU: case OP_MODS:
> > > +		if (insn->src2 == value_pseudo(0))
> > > +			warning(insn->pos, "divide by zero");
> > > +		break;
> > 
> > Is this divide by zero a new check?  I get the shift, but is this new?
> 
> Yes, and no. The warning is already given (using 'division by zero')
> but, like for shifts before this series, issued early, before dead code
> elimination is done. So, code like the following:
> 	...
> 	if (d != 0)
> 		r = a / d;
> 	...
> issues the warning nevertheless. So, the check here above is now unused
> but is a preparation for the part 2 doing the same for division by zero
> by zero.

I see, it's preparation for part 2, makes sense.

-Stafford

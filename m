Return-Path: <SRS0=CK19=DQ=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD10AC433E7
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8624722259
	for <linux-sparse@archiver.kernel.org>; Fri,  9 Oct 2020 16:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nurJKY9Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389452AbgJIQBp (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 9 Oct 2020 12:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389298AbgJIQBo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 9 Oct 2020 12:01:44 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E72EC0613D2
        for <linux-sparse@vger.kernel.org>; Fri,  9 Oct 2020 09:01:44 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id o18so9892490edq.4
        for <linux-sparse@vger.kernel.org>; Fri, 09 Oct 2020 09:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LE2fqCemB9GBaI5gzFQOxcmToWhrUQ0125hGVkdf+WU=;
        b=nurJKY9YWT/08CAfooZY+4BQuIQrH7Dk6RktlIzTugQimYofN/o5A82PaJt+T7HFrn
         swykNJl1HaPHkqiesz30ADqBks0miX1Uk28qCBK48GBbjaA73f4M2VkhJNeLlhV9Z+z7
         FTMG75/JLShUYAiLXFsTDeIH+1he4euKVTLKlPo2QHZmZ+PJO63CB5BmvKOFaFaBz5LM
         1YeKPLJ9gSY4vNfolZy8qh8p67EjsdwZXhCb1mGAVOJK77IpQpb9WVFc1W5k2EuCfuNH
         AqqhpCQQC9KmaK7ShRda6OST0+jFuxEVvIRqqxgCADc9XPtxQnYbZkbqQ56Dcwc2/9eK
         RINA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LE2fqCemB9GBaI5gzFQOxcmToWhrUQ0125hGVkdf+WU=;
        b=sCGlksG0x8ae1OGwcdSAKx04vUtxM03k9WFX2rvH1LK4hpLeC3/ooOL/4pbiRLfAsl
         g2R2a9l7FndUf2WLLHubix22ZZbwL0ivqYFH8fZI/NpT/SSCFDdd2GOzPwTGAx+6CRAn
         aQIRyzDiPm2YG/Ly7RM5FkoD/Tyis4Ol9s0nVBymFfnDsUFu7IVfvsLxWjUPwqjwSr7j
         xYK4hA5Y+c2ltTO/+Xjl3eiwc3J2pL3Uzm3W2JHw8X/1e8DTOrj9A+DqzFCw9DMiSnBb
         old8W1o91vBdpGPuUilfw/hhKU9tSYR8JDuJTZrfiQoo+3S2+eQI/RHEpuNUKYl024dl
         wbmg==
X-Gm-Message-State: AOAM532Vsu385XG4qtapTKhenGzWOMKAnIv563D14D1xDWTVO88eBMjy
        a/c6K9EiiJfx0Q6NM48V1yw=
X-Google-Smtp-Source: ABdhPJwxxKi6zM8qv15RI7CiMXVzEduOm3/pT82DVI9U6IXt2MG0BsHFpLBVmD8eeBQFcZdX35pxow==
X-Received: by 2002:a50:ab86:: with SMTP id u6mr15273812edc.158.1602259303221;
        Fri, 09 Oct 2020 09:01:43 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7fe:f700:b916:75c5:e328:ad7c])
        by smtp.gmail.com with ESMTPSA id p12sm6344356edr.18.2020.10.09.09.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 09:01:42 -0700 (PDT)
Date:   Fri, 9 Oct 2020 18:01:41 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ilya Maximets <i.maximets@ovn.org>
Cc:     linux-sparse@vger.kernel.org, ovs-dev@openvswitch.org,
        Ian Stokes <ian.stokes@intel.com>,
        Aaron Conole <aconole@redhat.com>,
        David Marchand <david.marchand@redhat.com>
Subject: Re: [PATCH] flex-array: allow arrays of unions with flexible members.
Message-ID: <20201009160141.hn2rhptqibrjyfxf@ltop.local>
References: <20201007115234.1482603-1-i.maximets@ovn.org>
 <20201007231554.d3vgykhycm3pcezg@ltop.local>
 <d7a476f9-0a35-12e9-e8cf-2cdc6521b294@ovn.org>
 <e2a2ef01-7432-9002-9be6-338a118bc4f4@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2a2ef01-7432-9002-9be6-338a118bc4f4@ovn.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Thu, Oct 08, 2020 at 12:04:55PM +0200, Ilya Maximets wrote:
> On 10/8/20 11:13 AM, Ilya Maximets wrote:
> > On 10/8/20 1:15 AM, Luc Van Oostenryck wrote:
> >> On Wed, Oct 07, 2020 at 01:52:34PM +0200, Ilya Maximets wrote:
> >>> The actual code in question that makes sparse fail
> >>> OVS build could be found here:
> >>>   https://github.com/openvswitch/ovs/blob/39fbd2c3f0392811689ec780f09baf90faceb877/lib/netdev-linux.c#L1238
> >>
> >> I'm impressed and surprised you're using of includes just for Sparse.
> >> I also see that this is since 2011. Just for my curiosity, have
> >> you an idea for why exactly this was needed and if it is still
> >> really needed?
> > 
> > There are some Sparse-related headers that could be safely removed now
> > because required functionality is already supported by Sparse.  We need
> > to clean this up someday, e.g. OVS builds fine without
> > include/sparse/threads.h since Sparse 0.5.1.
> > 
> > However, there are headers that are necessary for successful build.
> > There are few classes of issues that these headers are targeted on:
> > 
> > 1. Missing functionality in Sparse.
> > For example, it doesn't know about __builtin_ia32_pause, so we have to have
> > include/sparse/xmmintrin.h.
> > Sparse also doesn't know __atomic_load_n that comes from some DPDK headers.
> > OVS itself avoids using builtin atomics if __CHECKER__ defined.
> > DPDK library also has some issues with types in __sync_add_and_fetch, but I
> > do not remember exact problem.  We have include/sparse/rte_atomic.h for it.
> > These are from the top of my head.  I could go through our specific headers
> > and make a list of missing features someday if you're interested.

OK, I see. I'll add __builtin_ia32_pause() now and I'll look at
__atomic_load_n(), __sync_add_and_fetch() and friends soon.

> > 2. Sparse complains on standard libraries.
> > Complains on PTHREAD_MUTEX_INITIALIZER: 
> >     error: Using plain integer as NULL pointer
> > So, we have to have include/sparse/pthread.h.
> > Maybe some other examples, but I do not remember right now.
> > 
> > 3. Issues inside external libraries.
> > Ex. numa.h header from libnuma contains non-ANSI function declarations.
> > So we have include/sparse/numa.h.

It's always possible to use -Wno-non-pointer-null and
-Wno-old_-style-definition but ...

> > 4. Issues with restricted types (these are heaviest).
> > OVS uses restricted types like 'ovs_be32' inside (with __attribute__((bitwise))),
> > but standard functions like htonl() operates with usual 'uint32_t'.  While it's
> > safe to use these exact functions, Sparse complains about type mismatch.  One
> > option here is to explicitly cast arguments with (OVS_FORCE ovs_be32) each time,
> > but that is impractical (too many occurrences, ~4K lines of code only for hton/ntoh
> > conversions) and will make code less readable.  Much easier to override these
> > functions just for Sparse.  Ex. include/sparse/netinet/in.h.
> > 
> > Similar issue with some data types that goes from external libraries and system
> > headers. e.g. DPDK library operates with its own types like rte_be32_t.  While
> > it's completely safe to mix them with ovs_be32, Sparse doesn't know about that,
> > because DPDK doesn't mark them as bitwise.  This issue might be fixed on DPDK
> > side, I guess.  But Sparse will complain about different types even if these types
> > defined in exactly same way.  e.g. following test fails:
> > 
> > diff --git a/validation/bitwise-cast.c b/validation/bitwise-cast.c
> > index 0583461c..9284bd05 100644
> > --- a/validation/bitwise-cast.c
> > +++ b/validation/bitwise-cast.c
> > @@ -35,6 +35,18 @@ static __be32 quuy(void)
> >         return (__attribute__((force)) __be32) 1730;
> >  }
> >  
> > +/* Implicit casts of equally defined types, should be legal? */
> 
> I do understand why this is illegal.  Otherwise it will be not possible to
> create le and be types.  However, since the main purpose of 'bitwise' attribute,
> AFAIU, is to create le and be types, maybe it make sense to have 2 different
> attributes? e.g. 'bitwise_le' and 'bitwise_be'.  This way Sparse will be able
> to detect that 2 different types ovs_be32 and rte_be32_t could be safely mixed,
> if both defined with attribute 'bitwise_be' and has same base type uint32_t.

Well, one of the key characteristic of __bitwise is that it creates new,
distinct, incompatible types and it is very much used as such. For example,
in the kernel the 6 {be,le}{16,32,64} are maybe the most used but there
are about 100 other bitwise types that are defined (like poll_t or
pci_power_t) just to have a distinct type.

So, for the problem with rte_be32_t & ovs_be32, the solutions should be
to have a common definition, either via a macro or a typedef. Not an
easy thing with external libraries.
 
Best regards,
-- Luc

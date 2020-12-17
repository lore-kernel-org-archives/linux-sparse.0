Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6ECC4361B
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5208E23B1F
	for <linux-sparse@archiver.kernel.org>; Thu, 17 Dec 2020 00:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLQA6U (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 16 Dec 2020 19:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgLQA6U (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 16 Dec 2020 19:58:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE07C061794
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 16:57:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id cm17so26911996edb.4
        for <linux-sparse@vger.kernel.org>; Wed, 16 Dec 2020 16:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EkDqAF11k4XhjRf0cnqtNyCDnLsrQJbFpMDPNAgF/1k=;
        b=JdZzVl63Q6SCt7+itvsTnIwvgWqaUgbca2EqMrbKTDh7WyyM3OcVmImpp1ePm5lVwj
         HtsfvaWBAUrb50o814AUMz6g0kZjNeyFhqFmtgTwDm29GC7/3P9HrIUaWXA08nZVu2Ev
         NGYjCB9y0OUUS0w2P4fyx/rLDaMxv9m/jSfJxKoNNWlZmJ80O4Rimcw5oZwVuNi7IgXl
         jc5qKQA2I2+1rP9Keu9UPxJqMdinU6lun91O8lbR6cA9wzA8fhcXNgs6zQ1jWQxkU2Pi
         Ubgc7K4ZdEvRLpsKCDuxc41qc+E97Q01iVFjpbFq3O7I2/FwYoixOpamOXkBFobfhd7n
         z+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EkDqAF11k4XhjRf0cnqtNyCDnLsrQJbFpMDPNAgF/1k=;
        b=VSH0VT6wu/qxDeOnr59CgNR+BD6I1ea6s+bVrh9zF6oWta92cgADF7T0dYeub9Ishe
         uCb++e9NLSvZuA3hUBNI0+AdOspbLc/2BRO5Oq7TLe9uv2U3uadbUfRAA+O2RM6fsPHY
         wfdwQgmJhxl7IZkfvqw8uW+24WkcZ7fvJqmOngXF1YaWXdL6Wsd7PcwX05BbQP9KbWD2
         pYkURUTxItdp8qnA1Nk0yFtosEbVI0rHWzDq+xLG+M9UjjvMz7ty4LOAXJJyrx/kyQTt
         MoM+enJ80nUvEVy5wNo77UzxCMGndl/T2Scp9KgIyJqe1O7Yj04kKLHjXT3sWL4NL6AH
         udCA==
X-Gm-Message-State: AOAM533EI1gdoc+BXHhvxJdm+3ustoy93FPn4P5sVHc1gxMCENj1Mh8g
        ImqvZ+vZxUcwtlXVe79uQSVvykF7Pd0=
X-Google-Smtp-Source: ABdhPJwCmuv/aGVIB7ZrPZ8Tr6qAR3QzhmZ5ODBdH7yB3+FIn5p3RzW5mvK/1GKDRgzuRsFpyX0nPg==
X-Received: by 2002:a05:6402:229c:: with SMTP id cw28mr17219520edb.285.1608166658543;
        Wed, 16 Dec 2020 16:57:38 -0800 (PST)
Received: from ltop.local ([2a02:a03f:b7fe:f700:30ac:ec9a:2892:f5b7])
        by smtp.gmail.com with ESMTPSA id zn5sm2593230ejb.111.2020.12.16.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 16:57:38 -0800 (PST)
Date:   Thu, 17 Dec 2020 01:57:36 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: sparse attribute packed on structures
Message-ID: <20201217005736.xac6ryxknyqs7usy@ltop.local>
References: <0e8d816a-0849-c761-e0dc-93c3e5674e62@intel.com>
 <20201215205618.scarwvtzzhhtdwvk@ltop.local>
 <76c27364-e4cb-cdd4-6e55-178dd19c46ba@intel.com>
 <20201216233021.qcnvgsup7efwanqs@ltop.local>
 <09a4e340-76d4-9ae3-ffe3-6e44706200ae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09a4e340-76d4-9ae3-ffe3-6e44706200ae@intel.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, Dec 16, 2020 at 04:43:24PM -0800, Jacob Keller wrote:
> On 12/16/2020 3:30 PM, Luc Van Oostenryck wrote:
> > On Tue, Dec 15, 2020 at 03:15:48PM -0800, Jacob Keller wrote:
> >>
> >> I did find one bug, in your step (3), you have a check against
> >> info->packed on symbol.c:162 in lay_out_struct, but nothing ever set the
> >> packed value. I think you just need to initialized info->packed from
> >> sym_packed at the top of examine_struct_union_type, i.e.
> > 
> > A yes, I see, thank you. I think it was on purpose that it wasn't
> > yet enabled (things are it fuzzy because the code is ~2 year old)
> > and as I said it's unfinished.
> > 
> > But, with your change, does it handles 'packed' more or less
> > correctly?
> > 
> > -- Luc
> > 
> 
> Yes. Obviously we're limited in that we no longer check for
> out-of-bounds accesses on bitfields, but it at least produces the
> correct sizes for structures, and avoids the warnings that I was running
> into.

Nice, thanks for confirming this.
 
> Overall, I think the changes in that branch are solid, and look correct
> to me.
> 
> I'm not sure what all the limitations are of having it produce incorrect
> load/store operations that don't work with the packed bitfields.. but at
> least for the code I was checking, it seems to be correct now.

Oh, it's not much, just the usual. Currently, sparse always access a
bitfield with its base type. So, if we have the following:
	struct foo {
		int a;
		int b:24;
	} __packed;
	struct foo s;

Then accessing s.b will first load the full word and then mask the
upper bits, but:
1) this will access bytes 5,6,7 & 8 but the structure is only 7 bytes
   long and so the access checking should fail.
2) accessing byte-by-byte and then assemble the result is endian
   specific and until now sparse had succeed o ignore this kind
   of 'details'.

-- Luc

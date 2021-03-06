Return-Path: <SRS0=i4AA=IE=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A7EC433DB
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 17:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5506764FC1
	for <linux-sparse@archiver.kernel.org>; Sat,  6 Mar 2021 17:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCFRqU (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Sat, 6 Mar 2021 12:46:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCFRqI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 6 Mar 2021 12:46:08 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF3EC06174A
        for <linux-sparse@vger.kernel.org>; Sat,  6 Mar 2021 09:46:07 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x9so7889894edd.0
        for <linux-sparse@vger.kernel.org>; Sat, 06 Mar 2021 09:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=N1FwX0fduy2WpxOBMc/XDEW8k+Fok1F4BFbxBuh3b0s=;
        b=oOWXFmBXyvg08FobaJx0y1B0ismqIH8BoM+3tbO8f1yYgd9hJRk63A7OKK8CotNICS
         oZXZAhKXk3oO6vJcE87Zx0Bzn9acCV+vh6W2HixqK7QzVOZSRCVeRVn5XzQWy3fOYku5
         v5XOQGcxTIrU+nlrlg1+1d1bNFvDs7NmysqP5UYPjhIohN6Xite0mh5IC22yfZRIMPq4
         CE3BJT+lPMYWBhs0lAhz5xroXxAHkXBiTQQyTMHSPsTISczcnmCPNhfaf/MDDVRMoN5O
         58gYHeztvWDktoztz3weu5NCs0X8GeFc1fvuF8bnyg8G/J73y387krZiPeVhY05x5V2U
         W1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N1FwX0fduy2WpxOBMc/XDEW8k+Fok1F4BFbxBuh3b0s=;
        b=mDJIBG3d7AEoS4dd7AIVVlTAaUkXzJjBqmjUiJXwIatmigKtQYExOty6sfUoeKcUP7
         aBiKhWqAYzN/1ed82KbsQ1/SK3D1qL2xtC/9B/s4IUdhbsRp+74C6QU6vM5/uhXIhy4d
         TNijyRySwjQLFXoWfNUbijphjc3Inqhcl55vMf9KCNlDj1QpguA8gK1eAXs0TmyM9i3j
         p9VTm9zODb9v+NSrqLTZosgeggaesZ0r7pBJoLZeOwYCHdMA7ukVEnyaZmDdbG8oHO2D
         Y8AISIj0F2oKxnFSjP7XymfoKmaa2ruQjl1lgfHZb9ZiLB+mv2qM/2/6BiZHcp9DkGjR
         IIgA==
X-Gm-Message-State: AOAM533EqSR6g40izjy4h9ZkL135gNNLPzrJ+4Mmf3VfddilT5mzMx8S
        5o9uoQi5MMcN2D44z6EzBqbPHVhad2M=
X-Google-Smtp-Source: ABdhPJxghafZjX5NFDtO4PfNZIkvOR46gxyBzqBKFBQZ8R3mHqEq47iLJMJqSrU+mQ3iaOOiFtkLnQ==
X-Received: by 2002:aa7:c983:: with SMTP id c3mr14803036edt.185.1615052766346;
        Sat, 06 Mar 2021 09:46:06 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:b855:e560:6f86:989e])
        by smtp.gmail.com with ESMTPSA id u15sm4039542eds.6.2021.03.06.09.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 09:46:05 -0800 (PST)
Date:   Sat, 6 Mar 2021 18:46:04 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: [PATCH 6/6] ptrlist: change return value of
 linearize_ptr_list()/ptr_list_to_array()
Message-ID: <20210306174604.iki62afa2rv7xsvw@mail>
References: <20210306100552.33784-1-luc.vanoostenryck@gmail.com>
 <20210306100552.33784-7-luc.vanoostenryck@gmail.com>
 <b9f7ecdf-ee6d-0c77-560e-e05b26bcec02@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9f7ecdf-ee6d-0c77-560e-e05b26bcec02@ramsayjones.plus.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Sat, Mar 06, 2021 at 04:43:21PM +0000, Ramsay Jones wrote:
> On 06/03/2021 10:05, Luc Van Oostenryck wrote:
> > Change this, so that this function returns the total number of
> > entries in the list, much like it's done for snprintf().
> 
> But this requires setting max == 0, right? This isn't documented.

No no, there is nothing special with max == 0 at the interface level.
If the list contains 3 elements but you're only interested in the cases
it contains 2, you now call:
	... array[2];
	int nbr = linearize_ptr_list(list, array, 2);
and it'll only fill 2 elements but it will return 3, so can you write:
	if (nbr == 2) {
		... do stuff ...
	}
IOW, it returns the number of elements that would have been written
to the array if 'max' would have been infinite.

Previously, it would have returned 2 because the return value was
capped to 'max' / it returned he number of elements written. So you
had no idea if the list effectively contained only 2 elements of if
there was some more and so you had to call it with one extra element
to check this:
	... array[3];
	int nbr = linearize_ptr_list(list, array, 3);
	if (nbr == 2) {
		...
	}

Thanks for noticing all these typos,
-- Luc

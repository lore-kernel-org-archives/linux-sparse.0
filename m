Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F87C433B4
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Apr 2021 22:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7755613B2
	for <linux-sparse@archiver.kernel.org>; Mon, 19 Apr 2021 22:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240991AbhDSWBM (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhDSWBM (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 19 Apr 2021 18:01:12 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D57C06174A
        for <linux-sparse@vger.kernel.org>; Mon, 19 Apr 2021 15:00:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id sd23so46590991ejb.12
        for <linux-sparse@vger.kernel.org>; Mon, 19 Apr 2021 15:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PzXE1bg0ObDvY9PigwQhJYW/+2qMOPMYKPX+BM8uy1I=;
        b=D3uWihtDXd9PQKKGjKo9agPPOTFPGDQNNY+islBNzQHfT8SVnyqDVpHMWKR0MGH9g7
         3n3h3bV1jBCyMs6lWjupZ553WEEO4uZ0gRaRhJqLj8wFT6rnHT+1Ne5ULM8TwqYsMpyK
         dvb1oc1TvQLH+FWMdYfQlWgZMvk/e4fLVhvwksNeEuiuTUit0p9rbHcrIkxj8dLIYny0
         v+nrRKgy9gf7klOeUpdlZqcxjsMKluD2H2cbU2GneVF2y1B+eXOdXgLKnVxLPTuWwByl
         H4xpzSX92cG19DgLwDznbLW9YYb7qldEYKPn9FhiowVVz7DX9AcwprripGzPJJEHsyN+
         2D7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PzXE1bg0ObDvY9PigwQhJYW/+2qMOPMYKPX+BM8uy1I=;
        b=YfPaCmzYyoikrE+2RXEjszRHuhCNOPJbGTLfadK5LeTcbWbhAQPuMuzgxpSVu+Rlyx
         HtiE78Ih2Zmb+TUv8Td5R1yp8eQ2qwDr1qbf2R8RcwXuaK4NgmIEdbd7UyFYE0hex2Zw
         Mr41bcHhvWUEFRF62WVTUtbPbG6fawxIyLnqSROnQIO4A3jaMR7e90YgpCGJC49Qx2vT
         1OGM3JwUpuhILkkyGk+UFsrXXJ8AKwCYHfRmaqvVXNHJEhDPS4grDjicVOp6u5jEXMyT
         eEF4Q5Y+G+TSL7Aexiq25rDb7UDtzmc1qBY32H7ZmoCMPQpGio0Oux0rgvX6XFmnbetm
         YZ+w==
X-Gm-Message-State: AOAM53029rTwDrQxnpwXxLAPYDROW6sSZi5tAeoiCgXwpSCCIwP5GP/z
        aLmMnxELXbu8Vgg8kI6rzWbCoQ3WPw8=
X-Google-Smtp-Source: ABdhPJzJd61Tx+N3vhuKYIxNiww31ZvRXgrToToRRUZIQBGpOy51n1z72I7AO/wGHYYxu7ZAlkie+g==
X-Received: by 2002:a17:906:a0d4:: with SMTP id bh20mr24144327ejb.348.1618869639431;
        Mon, 19 Apr 2021 15:00:39 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:5087:6856:b985:723c])
        by smtp.gmail.com with ESMTPSA id n11sm14078347edo.15.2021.04.19.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 15:00:38 -0700 (PDT)
Date:   Tue, 20 Apr 2021 00:00:37 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Aptel <aaptel@suse.com>
Cc:     linux-sparse@vger.kernel.org
Subject: Re: check idea: warn when mixing signedness in ?: operator (got
 bitten by this recently)
Message-ID: <20210419220037.orvxzo7hnihcf7rq@mail>
References: <87wnsyzia4.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnsyzia4.fsf@suse.com>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Apr 19, 2021 at 12:21:39PM +0200, Aurélien Aptel wrote:
> Hi,
> 
> If the <then> and <else> expression in the ?: ternary operator have
> different signedness they will both be implicitely casted to unsigned.
> 
> When the result is stored in a variable with a storage capable of
> holding both values, this is very unexpected. Consider this example:
> 
>     int rc = -1;
>     unsigned int foo = 123;
>     long x = y ? foo : rc;
> 
> If one of the branch of the ?: is unsigned, then the compiler will cast
> both branch to unsigned _before_ storing it in x. Despite long being
> able to store INT_MIN, INT_MAX, UINT_MAX (assuming 64b long/32b int).
> 
> So if y is 0, it's basically doing
> 
>     long x = (long)((unsigned int)-1);
> 
> Which will result in storing 0x00000000ffffffff (4294967295) instead of
> expected 0xffffffffffffffff (-1).

Hmmm,
I'm wondering what you would be warned about:
- about 'y ? foo : rc' becoming unsigned?
- about the cast 'unsigned int' -> '(signed) long' doing an zero-extension
  and not a sign extension?

In both cases, it's not very different than:
	int rc = -1;
	unsigned int foo = 0;
	long x = foo + rc;

and it boils down to the difference between:
	long x = (long)((unsigned int)-1);
and
	long x = (long)((int)-1);

> I thought we hit some sort of weird compiler bug but after reducing the
> problem to the simple example above and trying it GCC, clang, ICC and
> MSVC they all do the same thing: https://godbolt.org/z/P5Ts7o1df
> 
> So it is most likely a C quirk. Standard reads 6.5.15. 5)
> > If both the second and third operands have arithmetic type, the result
> > type that would be determined by the usual arithmetic conversions, were
> > they applied to those two operands, is the type of the result.

Yes, it' also what Sparse is doing.

Cheers,
-- Luc

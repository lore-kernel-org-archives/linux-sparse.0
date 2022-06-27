Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 895B6C43334
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiF0TPW (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbiF0TPV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:15:21 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D58635E
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:15:20 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id s206so967465pgs.3
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BLjHr6T3ToOxk1Q56YEvMpJRaluHw4aCrNR0Nzvxt1c=;
        b=ArKTdbi8S6C5UB07ReiqZXT1z7zn4gDnSxJVYKDqd2W05LYGOngRPApRwVuciC0Zyy
         J21zTD3ymvisKxfXdzbbwnD9WyNnQwDoBaRsakNqiR9mjK2eFzfYoDWdlaQalx8iy9Ry
         7pH3ZaxUE2ifDi4R5M7J+bMl19Nklk5WQmathvjr/1T4jCiaNOGPSCrCHcqKp0CJ6oTy
         Gvqt5vdyr4tN05ZN+ZAdJzfstMGAxhUKGqwHITa3ylnpuq7epxl5Ih8fl61urwf6AHN0
         FyurqEeEh6tP4XPyo0PpoAtRM0AwxfSh5LXNZCdyuNGyaU8W87x9rBjdPdYNbTH41UQJ
         9bxA==
X-Gm-Message-State: AJIora/K8mTFiM+8eYeDhJSTUSVr9l8ESpjFmgxqxLDBlGRq7qZZGgYF
        mIlC8LA9kHd9RsTmlKlJ17s=
X-Google-Smtp-Source: AGRyM1sGtR/KxPvgdauRdFEE6yv9OinAZBn6uD50rWN9WDUUloxdlvt8bArP/akaGLo/chFcw+BVAA==
X-Received: by 2002:a63:1a52:0:b0:40d:9515:c113 with SMTP id a18-20020a631a52000000b0040d9515c113mr14108634pgm.312.1656357319366;
        Mon, 27 Jun 2022 12:15:19 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:ebc3:3a94:fe74:44f0? ([2620:15c:211:201:ebc3:3a94:fe74:44f0])
        by smtp.gmail.com with ESMTPSA id f16-20020a17090a121000b001ec8c8300f8sm9866779pja.52.2022.06.27.12.15.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:15:18 -0700 (PDT)
Message-ID: <b306f11d-d2d8-3cab-ee4b-4e29acfd42ea@acm.org>
Date:   Mon, 27 Jun 2022 12:15:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 0/5] allow -1 and compares in bitwise types
Content-Language: en-US
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220627190540.13358-1-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 6/27/22 12:05, Luc Van Oostenryck wrote:
> Allow using -1 and compare operators with bitwise types
> 
> This series is an experiment for allowing constants like
> -1 or ~0 with bitwise types, as well as using compares
> on them.

Will these changes cause sparse to stop complaining about
the following expression?

	cpu_to_le32(1) < cpu_to_le32(2)

Shouldn't sparse keep complaining about the above expression?

> @Bart,
> Is there a good reason why the macro compares against 1 and
> not against 0?

Maybe to prevent that gcc or clang issues the following
warning: "warning: comparison of unsigned expression in ‘< 0’
is always false"?

Thanks,

Bart.

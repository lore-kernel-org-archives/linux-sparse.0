Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFA2C433EF
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 09:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5349B6023B
	for <linux-sparse@archiver.kernel.org>; Tue, 28 Sep 2021 09:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240062AbhI1J5z (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 28 Sep 2021 05:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240054AbhI1J5y (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Sep 2021 05:57:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEDFC061575
        for <linux-sparse@vger.kernel.org>; Tue, 28 Sep 2021 02:56:15 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so90330737lfu.5
        for <linux-sparse@vger.kernel.org>; Tue, 28 Sep 2021 02:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sU/LhEZ8q3BeQ6P/PiHIYla/ZdlSW3YiCmnYV8PIXuI=;
        b=VZb+3cpQfdzvddM3ZSwyo95tO1IwqURM2VUyschymPHl9RVL+g8ruFk5g23boV7dhD
         nI0uXn9W2EmbAY9wgbbOZoGKTUdapoQYzHW5BdSyxvA7ygd+xNKNK5TilO2yE8708XAo
         7IWDjKg5fWb3I6i4p631kDaURnh4cIsZuiaHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sU/LhEZ8q3BeQ6P/PiHIYla/ZdlSW3YiCmnYV8PIXuI=;
        b=g+mszGND0rU5rzIkWxHBoiDnbkEP0avxOg6DIwbr3qmRWB6sdjF/VHjGIDrM8v73Zz
         JTbWNFPN+I3kZcNxBwxE9Jqjt3B9qSa2QByxwaiMutvr8BIKVXRALUnf2z5fGO03wzpo
         mIRxl5HjO52+TFuRGT4CBBtCMFfHlqSKQrFsOxEKURakLOdmo8m6GWb91HvHKEDTKhlS
         gz9/uc6lXzyJ9xh3vne11iG25JNQK968IhkdfJRbl692grAnLhAjXEZ1tLjTT5tcL+T3
         CV5JKnMO1sZJE/5UwtEMxAR/V4nimIqesavCNVhFAnkXdLo/BqoDdB3twTO3N88XlOZS
         pjMw==
X-Gm-Message-State: AOAM530P5U7LJpI0yBkH8/NIiV/Cztc2v8Xf0zxLtUMy1QN2Lh5yf8mb
        +AKaQs+m+ltBF0odOhijL3frTA==
X-Google-Smtp-Source: ABdhPJxjuKx366aHmjXKCPqMcpTQrMD3DfYUL7mY6FrOib4BAVfQ6jz5zRT6TMz0E0yCtzNZ314LdA==
X-Received: by 2002:a2e:974b:: with SMTP id f11mr4842574ljj.385.1632822973596;
        Tue, 28 Sep 2021 02:56:13 -0700 (PDT)
Received: from [172.16.11.1] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id y20sm2304960ljn.88.2021.09.28.02.56.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Sep 2021 02:56:13 -0700 (PDT)
Subject: Re: [PATCH] vboxsf: fix old signature detection
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-sparse@vger.kernel.org
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20210927094123.576521-1-arnd@kernel.org>
 <40217483-1b8d-28ec-bbfc-8f979773b166@redhat.com>
 <20210927130253.GH2083@kadam>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <78f6d6cc-2be5-c69b-bd17-7da135448438@rasmusvillemoes.dk>
Date:   Tue, 28 Sep 2021 11:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210927130253.GH2083@kadam>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On 27/09/2021 15.02, Dan Carpenter wrote:
> GCC handles it the same way as Clang.  '\377' is -1 but in Sparse it's
> 255.  I've added the Sparse mailing list to the CC.

FTR, while examples are not normative, this:

EXAMPLE 2 Consider implementations that use two's complement
representation for integers and eight bits for objects that have type
char. In an implementation in which type char has the same range of
values as signed char, the integer character constant '\xFF' has the
value -1; if type char has the same range of values as unsigned char,
the character constant '\xFF' has the value +255.

doesn't leave any ambiguity or (implementation|un)-definednes, and
sparse interpreting '\377' as 255 independent of its
target->unsigned_char is a plain bug in sparse.

Rasmus

Return-Path: <linux-sparse-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5925EC77B7D
	for <linux-sparse@archiver.kernel.org>; Wed, 17 May 2023 16:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjEQQkD (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 17 May 2023 12:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQQkC (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 17 May 2023 12:40:02 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73EEB3
        for <linux-sparse@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc22805d3so1581648a12.1
        for <linux-sparse@vger.kernel.org>; Wed, 17 May 2023 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=hJSArDsACQfgIfZm5gUboXLfaag3Cc98UHAkpAcbwjSjIyOWcTjMzYULTRwkLUsTBc
         Q6moqtReX3RXB65vJn4njVt1VF18bbqLOFraNA9bXXXFXhtZu7AqZ8icPXS/yqMHtGN0
         4E+pzVP7uoj7+5A2t9EcRD7+lOjwJP7YYHZoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341600; x=1686933600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUiZh9vX79/8GlRHS85iCL0x+Okzafu2CQZl4ySfqrA=;
        b=YDExlIw+qAtQU1xkFpH/XATcMGuZ0BzH8o8J247WUo5Robp3u52Gm013UVypPNvJ0K
         P8RbZlXPvANDnGCL6SqMPzlANkPjPi5LzsRg2ectvz4BeKOe4oFRnC3RZORzVE6kpWvI
         3v5ZnJnUm2xlBzmaLaswzaOgbGyZEIXJy6Q1GSqpavW1cYe6sM6ggIj/+er1DNnfxb29
         GtC1uVmFHpcwqIHQ995kK1PFm1PSbNHqtRwBD9LN7AZRpH/BlR3A88v06ZqeVGCjyVnd
         ZpXcWLPKo4fNoWEXItgtByGPqIn7xAPS+1CF1vGTYU5W7wL4LZyGO2HP2I+hjJxXCTmi
         7Pnw==
X-Gm-Message-State: AC+VfDz5kL/AKWPgXwp6pXsFDnK19MQFaBZ5YcCNCDjp7adsWNsmrqid
        iZdXvJsdJFicUwTVsyuB21tQvNnVicAx/axC6rFDTG6j
X-Google-Smtp-Source: ACHHUZ4SheyJDb4hZWe5ndHbrxn4aMomx/VTtrD+9tRZ+vjwR8EgGQS/oy7l2fugH1vr33/5+NefbQ==
X-Received: by 2002:a17:906:dc89:b0:957:862a:9e6e with SMTP id cs9-20020a170906dc8900b00957862a9e6emr48360244ejc.73.1684341599829;
        Wed, 17 May 2023 09:39:59 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709061f5300b009596e7e0dbasm12423371ejk.162.2023.05.17.09.39.59
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 09:39:59 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-9659443fb56so146166566b.2
        for <linux-sparse@vger.kernel.org>; Wed, 17 May 2023 09:39:59 -0700 (PDT)
X-Received: by 2002:a17:907:868f:b0:969:f9e8:a77c with SMTP id
 qa15-20020a170907868f00b00969f9e8a77cmr31038132ejc.64.1684341598769; Wed, 17
 May 2023 09:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230517124721.929540-1-arnd@kernel.org>
In-Reply-To: <20230517124721.929540-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 May 2023 09:39:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Message-ID: <CAHk-=wh+129KAcegJqvo2PKPUK3yw5qQwF0LcHofdT0bPbs8iQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: make ftrace_likely_update() declaration visible
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        linux-sparse@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Wed, May 17, 2023 at 5:47=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> This function is only used when CONFIG_TRACE_BRANCH_PROFILING is
> set, and the declaration is hidden behind this Kconfig symbol,
> which causes a warning if disabled:

That explanation is not very clear.

The problem is that the tracing code itself is built with
DISABLE_BRANCH_PROFILING, in order to not recurse. And that hides the
declaration when the definition is compiled, leading to the problem.

CONFIG_TRACE_BRANCH_PROFILING isn't the problem in itself - *that*
part of the test is consistent (not used, not declared, and not
compiled if it is off).

The problem is that DISABLE_BRANCH_PROFILING case, where it is used
elsewhere, but not declared when it is itself compiled.

I applied the patch, but I tried to reword the explanation to be more
clear. I may have failed.

          Linus

Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DDAC43334
	for <linux-sparse@archiver.kernel.org>; Tue,  7 Jun 2022 20:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357539AbiFGUMv (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Tue, 7 Jun 2022 16:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359137AbiFGUJh (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 7 Jun 2022 16:09:37 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573F91C4F13
        for <linux-sparse@vger.kernel.org>; Tue,  7 Jun 2022 11:26:55 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id q1so36919375ejz.9
        for <linux-sparse@vger.kernel.org>; Tue, 07 Jun 2022 11:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DCw08G+SEqa39b/et5gn5JnDtDhkvjyv3RPc3u1N8So=;
        b=Dx27OcWn1ugrJNpjWqjKvVsJVyArtJmKKU82f0TCI/lVqzbNIoiEv0wkZUVIVD/N7x
         4gkdbh3N/NdgdMuIQY3id+gIdshl+bYqdBVSwz/Jf1e5sah5CpaO57XqE2MVwtCC7aiu
         pBd0CabQ/wU6NpkYIVZJp+cx30JmHAmkAeRME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DCw08G+SEqa39b/et5gn5JnDtDhkvjyv3RPc3u1N8So=;
        b=KRKxbgoeU/IOfz+RjQJxQB8zLb34JCoy/bwGQ039KUXFGNhXW1rkqTqaipVHHpIgCV
         ICiM2a+AgAP4nDFTMBmGMCuS+CfoAg1py//lXz3/aUd3O94YISIMYRR/XgYKqWUH0IOV
         rykeCdEFre9lmTTdmTvPT+kYR0gxs28beMOhQfUGFlHr2dJtR2aJNEAnkpB6diZklArY
         R/lBYA4cJFLZ0ro8TfR9i3V5l8jaD7dIxwmZ03hPyEolrSoUU3lZAti0wJgPN+CQkCZS
         53haZdwtWt3bTpRCrjyg8F9Vy7REfup/bUBx/GzecnlppbTAjW/W7Hg1w7ZjzbbHVAgG
         EIzg==
X-Gm-Message-State: AOAM531An9r79PUnyvOk0Zo/gMeNu5ql6JwlqJTxzWV/fG/NmsplyZH1
        z+OWt4Xc8AZCMbjqyrEyJuB015Oh2lgIdLahmX4=
X-Google-Smtp-Source: ABdhPJx1dfXYe2Vc3572g9Mx3IFJqKACo7H+REFfRFMEBmrolfWUe5dZWuI7Yiljm1yrjT0j9Vhn9g==
X-Received: by 2002:a17:906:7951:b0:6fe:f0b0:8d1e with SMTP id l17-20020a170906795100b006fef0b08d1emr28258544ejo.300.1654626413570;
        Tue, 07 Jun 2022 11:26:53 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id d22-20020a50fb16000000b0042617ba6389sm10648916edq.19.2022.06.07.11.26.52
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:26:53 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id q7so25303846wrg.5
        for <linux-sparse@vger.kernel.org>; Tue, 07 Jun 2022 11:26:52 -0700 (PDT)
X-Received: by 2002:a5d:47aa:0:b0:218:5ac8:f3a8 with SMTP id
 10-20020a5d47aa000000b002185ac8f3a8mr1182332wrb.442.1654626412564; Tue, 07
 Jun 2022 11:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220607125441.36757-1-lucvoo@kernel.org>
In-Reply-To: <20220607125441.36757-1-lucvoo@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 11:26:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjYBPYsD-h_KkOG2zZTEXQ3yYEOzD_S83mnJqXjs1tcrQ@mail.gmail.com>
Message-ID: <CAHk-=wjYBPYsD-h_KkOG2zZTEXQ3yYEOzD_S83mnJqXjs1tcrQ@mail.gmail.com>
Subject: Re: [PATCH] allow show_token() on TOKEN_ZERO_IDENT
To:     Luc Van Oostenryck <lucvoo@kernel.org>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Tue, Jun 7, 2022 at 5:55 AM Luc Van Oostenryck <lucvoo@kernel.org> wrote:
>
> TOKEN_ZERO_IDENTs are created during the evaluation of pre-processor
> expressions but which otherwise are normal idents and  were first tokenized
> as TOKEN_IDENTs.
>
> As such, they could perfectly be displayed by show_token() but are not.
> So, in error messages they are displayed as "unhandled token type '4'",
> which is not at all informative.
>
> Fix this by letting show_token() process them like usual TOKEN_IDENTs.
> Idem for quote_token().

Ack.

I do wonder if it should be marked somehow as being that special case.
The main reason for 'show_token()' is debugging, after all, and
TOKEN_ZERO_IDENT does have magical properties in how it either
silently expands to the constant '0', or it generates a warning about
undefined preprocessor symbol.

But considering that we've apparently reported it as "unhandled token
type '4'" since 2005, I guess it's not exactly a big deal.

           Linus

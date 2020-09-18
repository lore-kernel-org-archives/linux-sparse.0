Return-Path: <SRS0=Wnm1=C3=vger.kernel.org=linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6A6C43464
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 19:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54FF921734
	for <linux-sparse@archiver.kernel.org>; Fri, 18 Sep 2020 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600457656;
	bh=DA+zkwlp2bUWWKEfbWP6ReafFTgGDYlmBmFbdGgIwJ4=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=J5Tr8N3VSKv1EYdk9Se7gfAat6cYAtDrk6E54TDs2+HO7/epRLI3l/4HsrgJ1FjCw
	 swRpgGS7xm/7gdMh9wlhea5b6eEais7pE/klEoBgAWgUyntopvnEB/26fADO2FxsVE
	 e4z7HLukB46GL43YwWB8eTjkb5XNZ2fQ3C5IzzZo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726154AbgIRTeQ (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Fri, 18 Sep 2020 15:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgIRTeP (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Sep 2020 15:34:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61006C0613CE
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 12:34:15 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b12so7303772lfp.9
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 12:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=T8YU6GKhujKuJkFP+oVqBNNPtxt40ye36Nv+rhw9vZY=;
        b=TSZjMRVqIj+LiySNekTJ/kBxIP/+lpOj+vdjYZFe0hyc6azWssw4J2enIw8aWO8WFv
         v3uEAzauwGpWXv8nfFEHMLLxlaaOXK4FswdOmHla2WrmPzbKRv3VLpbna2DtUfQyz3HX
         4xIZt50ctswgcIl+ahnNAwQ4lWHfGzNl7MV10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=T8YU6GKhujKuJkFP+oVqBNNPtxt40ye36Nv+rhw9vZY=;
        b=Vc5ZPvISrdSk6cgvM6gnIgIJK4IRAwwq16XT+sOXU4jp3BkONxC1Ql1xQKDyPceWSZ
         tAzdOk3GHocEQ7RTVEBH0J1NjEeo/kpRzgJKFjFdgx0xal1LjHMVK3ORBjefTqccNnZC
         aCyxFP5/IzxB6DO62mx0nV0nl3xpD9Ah1ZOBZKQR/SiwXvEDpJJErKxVwJsor7RfSlp7
         r2jbuDCJe/JcpS15OICDsMhNwI9VzFrB/Ri9OIhCSkfUdX+r/XPQ200CWvxqIzFqZK6/
         6nLFfmdOGdUbtQw/TQnZhfosRFF6kxK0a0UpDW3OSzFKP2v+DsWAlbtybPHCr+892huV
         S+ww==
X-Gm-Message-State: AOAM531IdDQVQtA6J1QImDQL89NxyZ1eq2RIVg7WzNpcivcZRjhcf73I
        yTuQsyafioKYtlsSvuyLpq0eu4k3fEVyLA==
X-Google-Smtp-Source: ABdhPJyFI01z0GfiZwxHwVFneobF8DLUxaT8GdRZnkk4S/T4j5X74abWlCEO19AAsb364TjCEnhNcg==
X-Received: by 2002:a19:c48:: with SMTP id 69mr10709778lfm.262.1600457653358;
        Fri, 18 Sep 2020 12:34:13 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id y9sm758436lfg.293.2020.09.18.12.34.12
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2020 12:34:12 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id w3so6009166ljo.5
        for <linux-sparse@vger.kernel.org>; Fri, 18 Sep 2020 12:34:12 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr11436098ljp.314.1600457652002;
 Fri, 18 Sep 2020 12:34:12 -0700 (PDT)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 18 Sep 2020 12:33:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
Message-ID: <CAHk-=wgJZ05ap8VQdzWDWJVWVtZiOYTc6cnNB8gNeQzEnfm-tw@mail.gmail.com>
Subject: Making structs with variable-sized arrays unsized?
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

Luc,
 we've been making kernel structures use flexible arrays as a
cleanliness thing, but it turns out that it doesn't find bugs that it
_should_ find.

We have that nice "struct_size()" macro to determine the size of the
flexible structure given the number of elements, which uses "offsetof
+ n*members". But sadly standard C still allows the (nonsensical)
'sizeof()' to be used - and I merged another fix for that just today.

Ok, so that's a C standard problem, but it's something that sparse
*could* warn about.

Comments? Appended is a kind of test-case for odd situations that
sparse happily and silently generates nonsensical code for (just
tested with test-linearize).

              Linus

---

    struct bad {
        unsigned long long a;
        char b[];
    };

    // An option to warn about this?
    static struct bad array[5];

    int odd(struct bad *a);
    int not_nice(struct bad p[2]);
    int please_fix(struct bad *p);
    void weird(struct bad *dst, const struct bad *src);

    // The layout is odd
    // The code does "info->align_size = 0" for unsized arrays, but it
still works?
    int odd(struct bad *a)
    {
        return __alignof__(*a);
    }

    // Arrays of flexible-array structures are pretty nonsensical
    // Plus we don't even optimize the constant return. Sad.
    int not_nice(struct bad p[2])
    {
        return (void *)(p+1) - (void *)p;
    }

    // This should at least have an option to warn
    int please_fix(struct bad *p)
    {
        return sizeof(*p);
    }

    void weird(struct bad *dst, const struct bad *src)
    {
        *dst = *src;
    }

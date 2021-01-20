Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0669BC433E0
	for <linux-sparse@archiver.kernel.org>; Wed, 20 Jan 2021 19:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A155C23403
	for <linux-sparse@archiver.kernel.org>; Wed, 20 Jan 2021 19:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390308AbhATTW6 (ORCPT
        <rfc822;linux-sparse@archiver.kernel.org>);
        Wed, 20 Jan 2021 14:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391913AbhATTWq (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 20 Jan 2021 14:22:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53835C061575
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2021 11:22:06 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id v24so29033127lfr.7
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2021 11:22:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7KT5UJjmX7L0oLprbkyn/rCgq72zF3oMKSwzXpjysR8=;
        b=XbUB5JU6fErExGjx7SXt66vwq2scA5B0t/Q4BoUzuAnXBpk++kVArOwcJu6ZtKiBlL
         GItsC7e93YEs2JNf+BfZcex1am/pvoBRMKcL2B0/QhB80r4RCHxlwbjElBkk32xnGSFc
         n98XMflPWyWCcXTIr/zfj2SGxfQMWh4AIHJoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=7KT5UJjmX7L0oLprbkyn/rCgq72zF3oMKSwzXpjysR8=;
        b=pdHch+0UfFNhUCRO4ZHVMtO6pIj9yzMLSRLCQBzPycllEXYJjZ91Z2zJ+zfn4jrfh/
         T6TxPTYpmtXOiG5bg88L6PKPOQKkMb2lZZiiGBV4wS69mD5U6c+DRyBqtjj7W5M0rat8
         kkpXkR7IQIfjwqUcckCVEx7i0H3zhsu1FnuEI1JlxDTiY7uWR898aKAoIubWAWEtmPg9
         AQrjVCgeTbDk0npgotpcHNxmlJzubMOOmtcUeNoElGp53TdtuY4v7EvJuilk6JOWM/xA
         gKkQnOoTZ0bfhMLnB8LNQLBtIvukioebpMjk5IcSBxIS2brdVH6GWHS6J36LuRnByT+7
         Dakw==
X-Gm-Message-State: AOAM531eT+2Hw9EL8JpHX0b3c0LKKhJTxJ3h1PcOa8B/7L+/HeVB6/m+
        a5LEXihj1ykKIUgYHpM38uNY4jnYFrsJ6w==
X-Google-Smtp-Source: ABdhPJzJOO5osp6o1C0xkAjY46AWmgWT+nVUivxqQdiLhrafXMsBPUxtlj+TGO3kWlLLMaX3QOUsoQ==
X-Received: by 2002:a19:5218:: with SMTP id m24mr4836776lfb.232.1611170524290;
        Wed, 20 Jan 2021 11:22:04 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id j23sm276273lfh.194.2021.01.20.11.22.03
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jan 2021 11:22:03 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id i17so2259378ljn.1
        for <linux-sparse@vger.kernel.org>; Wed, 20 Jan 2021 11:22:03 -0800 (PST)
X-Received: by 2002:a2e:8995:: with SMTP id c21mr4903334lji.251.1611170522671;
 Wed, 20 Jan 2021 11:22:02 -0800 (PST)
MIME-Version: 1.0
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Jan 2021 11:21:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
Message-ID: <CAHk-=wj4Kviw8q2Sx9vrrvyn3uWK-zNi4uGRx=5bzde0Cio8uQ@mail.gmail.com>
Subject: 'const' unnamed structures
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

So the kernel was trying to use a unnamed struct to mark a group of
fields as being 'const', and while gcc is perfectly happy with that,
it turns out clang is not.

And while testing, I notice that sparse is also not happy with it.

Stupid test-case:

    struct dummy {
        const struct {
                int a, b;
        };
        int c;
    };

    void test(struct dummy *a)
    {
        a->a =3D a->c;
    }

and gcc will report

    t.c: In function =E2=80=98test=E2=80=99:
    t.c:10:7: error: assignment of member =E2=80=98a=E2=80=99 in read-only =
object
       10 |  a->a =3D a->c;
          |       ^

which is the helpful message we're looking for in the kernel, but
clang and sparse both silently accept this. Presumably for very
similar reasons.

(And when I talk about 'const', obviously all the same issues hold wrt
'volatile' too)

Basically, I see two possibilities

 (a) since the const is there in the unnamed sub-struct, we can "fix"
it at evaluate lo time, in find_identifier().

     We'd have to add a "unsigned int qual" as an argument - initially
zero - to "find_identifier()", and then in the recursive unnamed
union/struct case we'd or in the qualifiers for this one.

     And then we'd modify the symbol result as per the qualifier when
we return it.

Honestly, (a) strikes me as ugly and wrong, but it might be simpler
than what I think might be the right model:

 (b) examine_struct_union_type() knows when it is traversing an
unnamed union,  and when it does that

                examine_symbol_type(member);

     it would then add the modifiers after-the-fact.

Obviously, the third possibility is to say "ok, clang also gets this
wrong, the clang people are trying to argue that the standard is not
clear about it, and sparse might as well ignore this until it's a
bigger problem".

           Linus

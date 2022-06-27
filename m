Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1202C433EF
	for <linux-sparse@archiver.kernel.org>; Mon, 27 Jun 2022 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiF0TUX (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 27 Jun 2022 15:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbiF0TUW (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 27 Jun 2022 15:20:22 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76187B482
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:20:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id cf14so14458641edb.8
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XS8Sw0HZbV+YwphYe57/6LdokvT5GZYB3n7iaIGDRYY=;
        b=Ml3IzjGALbtfgxW18NW2XHtiGIxGEVlmSN5PrbrPr17pyOAmvEd/B5rEdaF+wFWybD
         JE9wRL5Hmm6sKxE46D4bYykmmrB6PHfC1nxPf7ekWtdpZEbLXXBRPeKhNcWpItehyD7r
         T+Hp+Z6EafZj+3Pu8hGKJTrP69FiAyXOGfA1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XS8Sw0HZbV+YwphYe57/6LdokvT5GZYB3n7iaIGDRYY=;
        b=NNNNLPO9b/shCclaqQ4w9WiQPCNs0lzxkPjzexFPOp3XkjK+kF9W6ODeJQ6t7r55zG
         XavBYc39ufKzlj4FRlpS/JKhrQmCE+khc9nqpWAznIMBNnOX5REY6q5mPiGbvp/W0ZO/
         6ZlZKlrB4yT+pHDadAidK/C15uzdXGBxHL7uMCQe41w/6HhHz75B5W0gCR9TgZnKj0d6
         5cFGGaq0nH6ax8gXSRiqKyrR550qjFtTjV70W0R2ot7zA8evyTl1DM9JbYqiGmHTRAGA
         jJl10HnHL5IUqv3ds5zrNKMC2C2vDxtYEx5GewpjFCbxO3f8xkzTxFuyombp4s95h8Iu
         GS7Q==
X-Gm-Message-State: AJIora+NDfb7eSsSrtDPMfNSvlGwfryKg7+kte5p7/VooBxk+xWMZBtg
        S13D7+9gTqmQyHj5zSTYLNfrh+/V/7WIuwPOS40=
X-Google-Smtp-Source: AGRyM1vlj1mlOisymrOPCoY7Crb+GXWaZVrGg32/h3cGbg9PYnpwp1H3hGdz9hJJxPgPYxSYrD8ajQ==
X-Received: by 2002:a05:6402:3807:b0:435:20fb:318d with SMTP id es7-20020a056402380700b0043520fb318dmr18443631edb.272.1656357619631;
        Mon, 27 Jun 2022 12:20:19 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id z23-20020a170906435700b007094f98788csm5356484ejm.113.2022.06.27.12.20.18
        for <linux-sparse@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 12:20:19 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id e28so9260079wra.0
        for <linux-sparse@vger.kernel.org>; Mon, 27 Jun 2022 12:20:18 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr13493238wrx.281.1656357618629; Mon, 27
 Jun 2022 12:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj8gM8q04v2jS5JGjEdoE2d+B4_nm74xrFjZ77f9YRsbA@mail.gmail.com>
 <20220627190540.13358-1-luc.vanoostenryck@gmail.com> <20220627190540.13358-4-luc.vanoostenryck@gmail.com>
In-Reply-To: <20220627190540.13358-4-luc.vanoostenryck@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jun 2022 12:20:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi2eLQzBKrjVogJR_vKGDNM3f4ityrS=zgq2B38Yk5Qpw@mail.gmail.com>
Message-ID: <CAHk-=wi2eLQzBKrjVogJR_vKGDNM3f4ityrS=zgq2B38Yk5Qpw@mail.gmail.com>
Subject: Re: [PATCH 3/5] bitwise: allow compares for bitwise types
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Sparse Mailing-list <linux-sparse@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Jun 27, 2022 at 12:05 PM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Currently, bitwise types are restricted to bitwise operations
> (&, |, ^ and ~) as well as equality comparisons.
>
> This patch makes the others comparisons valid for bitwise types
> too.
>
> Warning: This change make sense in the context of [1] but
>          doesn't make sense for the 'main' bitwise types:
>          __be32 and friends.

Yeah, this is wrong.

It will literally break one of the use-cases, which is endianness comparisons.

You cannot compare values in the wrong endianness for greater-than or
less-than, because you will get the wrong answer - the ordering is
different in different byte-orders.

But comparing for equality (and inequality) is fine, and we actually
do that in the kernel (ie you can take a big-endian value, and compare
it with another big-endian value for being equal, without converting
it to the local CPU endianness).

Now, comparing the *constants* 0 and all-ones is fine. They are
smaller than (and larger than) all other values, regardless of any
byte/bit order issues.

So I think that really needs to check that one (or both) sides are the
magic constants.

             Linus

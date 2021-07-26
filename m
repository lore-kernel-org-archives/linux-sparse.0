Return-Path: <linux-sparse-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D027AC4320E
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 15:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BCC60F38
	for <linux-sparse@archiver.kernel.org>; Mon, 26 Jul 2021 15:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhGZPLF (ORCPT <rfc822;linux-sparse@archiver.kernel.org>);
        Mon, 26 Jul 2021 11:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbhGZPKa (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 26 Jul 2021 11:10:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A491FC061765
        for <linux-sparse@vger.kernel.org>; Mon, 26 Jul 2021 08:50:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id gt31so16978644ejc.12
        for <linux-sparse@vger.kernel.org>; Mon, 26 Jul 2021 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LZ3WNm3cTuH36LiZ/1QHfuTo7DPM1vDnHijtTeYDSNE=;
        b=N5uv0rDUYbLUx3HCaoe+BtwX9GOR3y1/XbZDHkFFtYdC0DQjzcIYhdJ1BF7NcSji+A
         4fEQ9OF3IoTQsr/ozifYvAg9j01/GqdkFtOZqXcND78quTV08uWPl8uqDiM0vCkewO6I
         /fAD/tC70FxUjW8fruCWo7cQqLegRswmmeHV30ubZ4Ookk1/7NiC5kx0OuoPHg6Ge3tj
         drB4hP5LwxS44MBXl4i41toE+fDdMi9G7w1oKrGZwo7BGLVr815xrOHvHaU2iYU3Jygd
         WQG9AEETHmB8AT/zfzcYO1NYAc3tx0g0/k2JnandUOKCGBKOWzJt1huJ6zUgi1F4aTxW
         o92g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LZ3WNm3cTuH36LiZ/1QHfuTo7DPM1vDnHijtTeYDSNE=;
        b=lV7NZY5eL7gOk68j93gPWxCLI5gvLjBe4l67xsYVJNCkc21BX4HRM/mfT7UgPYYBAr
         K0gcnjGw2Ujz3RREomU00H7po8eR/DzvJoEM46qdPswqtB+TMfIgD3t2QYE+Wp+3TPMT
         Af+0Itdsd4RwbLtxXVaKLwyJgelV33VVPyi4tCgx8O1NczBMoerS2mi7GKplBhlDXu3e
         PIzBNOeep+MqencAuRL2b2ngJxajQU2iNmsRdYIL05xTfUNdEOHKnjOeu4eF7b/DrD2R
         c5pCPzBh0IQ9wuKIzylqtwl7rUPSREo8d4Y1CGwWGPgN9xeGdYv6KPsbopxYdWvqKKy1
         ytjQ==
X-Gm-Message-State: AOAM530pgw/JWfHiHD7BCQu/qsI87DJXlvbiLRhhwGHZNQIEx0rfnpzx
        kXEM9ZZrNB0I+UMc8L1B1/M=
X-Google-Smtp-Source: ABdhPJzwexGbHShkW9xFme9al0ZjbdrSm8m03DiNHuwft4q2MF/8nHjKrizOVWLx2SFOLBpFtv5fVg==
X-Received: by 2002:a17:906:3042:: with SMTP id d2mr17855292ejd.234.1627314647843;
        Mon, 26 Jul 2021 08:50:47 -0700 (PDT)
Received: from mail ([2a02:a03f:b7fe:f700:7d98:546b:4541:6897])
        by smtp.gmail.com with ESMTPSA id s3sm32692ejm.49.2021.07.26.08.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 08:50:46 -0700 (PDT)
Date:   Mon, 26 Jul 2021 17:50:45 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-sparse@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck.ml@gmail.com>
Subject: Re: new sparse release?
Message-ID: <20210726155045.fo6nh4lryln5sgxl@mail>
References: <c7963e9e4c7d5b91fc8bee9c9ae9a9c893664e0b.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7963e9e4c7d5b91fc8bee9c9ae9a9c893664e0b.camel@kernel.org>
Precedence: bulk
List-ID: <linux-sparse.vger.kernel.org>
X-Mailing-List: linux-sparse@vger.kernel.org

On Mon, Jul 26, 2021 at 07:20:28AM -0400, Jeff Layton wrote:
> It's been quite a while since we've had a new sparse release and there
> are some fixes that I'd like to see in the fedora package. I could just
> cut a release from a current git snapshot, but I don't want to do that
> if there are any plans to do a release soon. 
> 
> Any idea when the next sparse release will be?

I've been quite a bit side-tracked lately and as such I had nothing
really planned. But yes, it's been a while with enough changes already.
I've a few minor fixes I would like to add and a bigger series (but
one 'm not really happy with). I'll see what I can do n the next days
but the idea would be to do a -rc next WE and the full release a few
days later (so around Aug 5) if nothing serious come up.

Would this be OK for you?

-- Luc

From: Christopher Li <sparse@chrisli.org>
Subject: Re: Sparse 0.5.1 RC5 released.
Date: Mon, 14 Aug 2017 14:52:10 -0400
Message-ID: <CANeU7QmaBHLLkXFNZt38wpBGUpaAK38SwWOkJM_hCzs2ijEPaw@mail.gmail.com>
References: <CANeU7Qkr5CPe2uEHx3-gR+dPc5C9_kKYCB=AHVLrPw+JXZ8=yw@mail.gmail.com>
 <CACXZuxeoO0Udx41Qk4JJjM9fXTa4ta2X-yAyKsY+1SkOrxQE-A@mail.gmail.com>
 <CANeU7QmkJjxr_AmBTrDhVz6VP3oZcs-8xAL3kXegrWozqkvZGA@mail.gmail.com>
 <CACXZuxfaPNCWx1+Oy08ZqfRY+eNtZ5rWpLjyHaXnK3kuvur3LQ@mail.gmail.com>
 <CAExDi1R1mQvth6OcWBZP-ur_xLfPztfaAtZWW0U8Sz=QSuW1Rw@mail.gmail.com>
 <CACXZuxfitdon6pOKxwNH2uSv2CR_-4UxzfbgsJx0TqwkP=VgPA@mail.gmail.com>
 <CAExDi1Qcox7wBFEnRKN5Cvk1miupBD9jXT7_W7+JiNqESHXX5Q@mail.gmail.com>
 <CACXZuxfWAYNj3idcoWF2b4pcVHYQ5nOoASD8yG=n5NrT=WU+eg@mail.gmail.com>
 <CANeU7Q=-vw1=HgVqs7B-4gHj+Ysr6CVQvr+FpvW7ZNgsf7c=Vg@mail.gmail.com> <CACXZuxfHu8M1Lxpjmtj6=HS8T0o5dvDzmSryEqkKn6iG7MAxTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35248 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdHNSwL (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 14:52:11 -0400
Received: by mail-yw0-f169.google.com with SMTP id l82so60005122ywc.2
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 11:52:11 -0700 (PDT)
In-Reply-To: <CACXZuxfHu8M1Lxpjmtj6=HS8T0o5dvDzmSryEqkKn6iG7MAxTw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dibyendu Majumdar <mobile@majumdar.org.uk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Ramsay Jones <ramsay@ramsayjones.plus.com>, Lance Richardson <lrichard@redhat.com>, Michael Stefaniuc <mstefani@mykolab.com>

On Mon, Aug 14, 2017 at 2:48 PM, Dibyendu Majumdar
<mobile@majumdar.org.uk> wrote:

>
> https://github.com/dibyendumajumdar/dmr_c/blob/mergesparse/tests/lcc/cq.c
>

Can you run a preprocessor output and put it some where in online?

You can do "sparse -E ...." the rest of normal flags.

That way I can duplicate it here with RC5, otherwise
I need to duplicate your project compile environment.

Chris

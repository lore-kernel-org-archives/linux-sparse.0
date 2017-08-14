From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Re: Bad linearized output in RC5
Date: Mon, 14 Aug 2017 16:48:53 +0100
Message-ID: <CACXZuxfsgsj3AQs9cSYHAyRhW+VPNufjuB7N4vzbDy4Ov7rdGQ@mail.gmail.com>
References: <CACXZuxf=pO2pXmJoTtWvO2d7HCzpyfCWOqc4EJ7fBjyh7fdsWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:33499 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753690AbdHNPsz (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 14 Aug 2017 11:48:55 -0400
Received: by mail-ua0-f173.google.com with SMTP id 80so38241622uas.0
        for <linux-sparse@vger.kernel.org>; Mon, 14 Aug 2017 08:48:54 -0700 (PDT)
In-Reply-To: <CACXZuxf=pO2pXmJoTtWvO2d7HCzpyfCWOqc4EJ7fBjyh7fdsWw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

On 14 August 2017 at 08:28, Dibyendu Majumdar <mobile@majumdar.org.uk> wrote:
> Hi,
>
> There appears to be a problem handling following:
>
> typedef struct lua_TValue {
>         double value;
>         int tt;
> } TValue;
> typedef TValue *StkId;
> struct lua_State {
>         StkId top;
>         StkId base;
> };
> static void lua_settop(struct lua_State *L, int idx)
> {
>         if (idx >= 0) {
>                 { (void)L; };
>                 while (L->top < L->base + idx)
>                         ((L->top++)->tt = 0);
>                 L->top = L->base + idx;
>         } else {
>                 { (void)L; };
>                 L->top += idx + 1;
>         }
> }
>
> This generates:
>
> lua_settop:
> .L0:
>         <entry-point>
>         setge.32    %r2 <- %arg2, $0
>         cbr         %r2, .L6, .L2
>
> .L6:
>         load.64     %r5 <- 0[VOID]
>         load.64     %r7 <- 8[VOID]
>         scast.64    %r9 <- (32) %arg2
>         muls.64     %r10 <- %r9, $16
>         add.64      %r11 <- %r7, %r10
>         setb.32     %r12 <- %r5, %r11
>         cbr         %r12, .L3, .L5
>
> .L3:
>         add.64      %r15 <- %r5, $16
>         store.64    %r15 -> 0[VOID]
>         store.32    $0 -> 8[%r5]
>         br          .L6
>
> .L5:
>         store.64    %r11 -> 0[VOID]
>         br          .L7
>
> .L2:
>         add.32      %r25 <- %arg2, $1
>         scast.64    %r26 <- (32) %r25
>         muls.64     %r27 <- %r26, $16
>         load.64     %r29 <- 0[%arg1]
>         cast.64     %r30 <- (64) %r29
>         add.64      %r31 <- %r30, %r27
>         ptrcast.64  %r32 <- (64) %r31
>         store.64    %r32 -> 0[%arg1]
>         br          .L7
>
> .L7:
>         ret

Interestingly with single store shortcut enabled the output (from dmrC
this time) is:

lua_settop:
.L0:
        <entry-point>
        setge.32    %r2 <- %arg2, $0
        cbr         %r2, .L6, .L2

.L6:
        load.64*    %r5 <- 0[%arg1]
        load.64*    %r7 <- 8[%arg1]
        scast.64    %r9 <- (32) %arg2
        muls.64     %r10 <- %r9, $16
        add.64*     %r11 <- %r7, %r10
        setb.32     %r12 <- %r5, %r11
        cbr         %r12, .L3, .L5

.L3:
        add.64*     %r15 <- %r5, $16
        store.64*   %r15 -> 0[%arg1]
        store.32    $0 -> 8[%r5]
        br          .L6

.L5:
        store.64*   %r11 -> 0[%arg1]
        br          .L7

.L2:
        add.32      %r25 <- %arg2, $1
        scast.64    %r26 <- (32) %r25
        muls.64     %r27 <- %r26, $16
        load.64*    %r29 <- 0[%arg1]
        cast.64     %r30 <- (64) %r29
        add.64      %r31 <- %r30, %r27
        ptrcast.64* %r32 <- (64) %r31
        store.64*   %r32 -> 0[%arg1]
        br          .L7

.L7:
        ret


What this tells me is that potentially there is a bug in the way
single store shortcut has been removed - i.e. it is having a different
effect here.

Regards
Dibyendu

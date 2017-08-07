From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Best way to inspect the parse tree from Sparse
Date: Mon, 7 Aug 2017 16:11:43 +0100
Message-ID: <CACXZuxdB3HKmTvh8Xa41OD+3-R4_Hx5g8OqS_D6H093Etb0y2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:38386 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751396AbdHGPLp (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 7 Aug 2017 11:11:45 -0400
Received: by mail-wm0-f45.google.com with SMTP id m85so9507315wma.1
        for <linux-sparse@vger.kernel.org>; Mon, 07 Aug 2017 08:11:45 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I would like to understand the structure of the parse tree generated
by Sparse a bit better. I am looking at the output from the show_*()
functions but it is not clear to me exactly what the output means. For
example:

extern int printf(const char *, ...);

int main(int argc, const char *argv[]) {
printf("hello world!\n");
return 0;
}

Results in:

.align 4
int extern [signed] [addressable] [toplevel] main( ... )
        movi.64         v2,&"hello world!\n"
        push.64         v2
        call            printf
        add.64          vSP,vSP,$8
        mov.32          v3,retval
        movi.32         v4,$0
        addi.64         v5,vFP,$offsetof(return:00000202755B1A98)
        st.32           v4,[v5]
        ret             (00000202755B1A98)
.L00000202755B1A98:
        addi.64         v6,vFP,$offsetof(return:00000202755B1A98)
        ld.32           v7,[v6]
        mov.32          retval,7
        ret


I get the first four lines, but the rest don't make sense to me. I
suppose that the dump is trying to show the parse tree in a linear
form ...  but is that useful? Would it be better to dump the parse
tree in a different form?

Regards
Dibyendu

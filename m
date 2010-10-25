From: Christopher Li <sparse@chrisli.org>
Subject: Re: bad asm goto ?
Date: Mon, 25 Oct 2010 16:44:32 -0700
Message-ID: <AANLkTi=r6U3CVS5Br5ZTVVyNEfKzhqTcKkEk5+itwNe1@mail.gmail.com>
References: <20101025213145.GA1822@redhat.com>
	<AANLkTikVt5BJ+2W3P+wYUR3DLzhTatXhAW45wdc0eoOe@mail.gmail.com>
	<20101025223957.GA5561@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44942 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab0JYXod convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 25 Oct 2010 19:44:33 -0400
Received: by ywk9 with SMTP id 9so2545215ywk.19
        for <linux-sparse@vger.kernel.org>; Mon, 25 Oct 2010 16:44:32 -0700 (PDT)
In-Reply-To: <20101025223957.GA5561@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Oct 25, 2010 at 3:39 PM, Dave Jones <davej@redhat.com> wrote:
> I tried unwinding some of the nested macros, and came up with ..
>
> # define __ASM_FORM(x) =A0" " #x " "
> # define JUMP_LABEL_INITIAL_NOP ".byte 0xe9 \n\t .long 0\n\t"
> # define __ASM_SEL(a,b) __ASM_FORM(b)
> #define _ASM_PTR =A0 =A0 =A0 =A0__ASM_SEL(.long, .quad)
>
> # define JUMP_LABEL(key, label) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0do { =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0asm goto("1:" =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0JUMP_LABEL_INITIAL_NOP=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0".pushsection __jump_t=
able, =A0\"a\" \n\t"\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_ASM_PTR "1b, %l[" #la=
bel "], %c0 \n\t" \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0".popsection \n\t" =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0: : =A0"i" (key) : =A0=
: label); =A0 =A0 =A0 =A0 =A0 =A0 \
> =A0 =A0 =A0 =A0} while (0)
>
> int main(int argc, char *argv[])
> {
> =A0 =A0 =A0 =A0JUMP_LABEL("1", do_trace );
> =A0 =A0 =A0 =A0return 1;
> do_trace:
> =A0 =A0 =A0 =A0return 0;
> }
>

Thanks, I got this example working for me too. You are right, sparse is
choking on it. Let me take a look tonight.

Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

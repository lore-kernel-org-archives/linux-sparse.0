From: Christopher Li <sparse@chrisli.org>
Subject: Re: typedefs and alignment
Date: Tue, 9 Feb 2010 17:36:27 -0800
Message-ID: <70318cbf1002091736s3ca92377pfc97c2fcf9e15478@mail.gmail.com>
References: <20100208103501.GA14210@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qy0-f190.google.com ([209.85.221.190]:38805 "EHLO
	mail-qy0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755131Ab0BJBnJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Feb 2010 20:43:09 -0500
Received: by qyk28 with SMTP id 28so1030066qyk.25
        for <linux-sparse@vger.kernel.org>; Tue, 09 Feb 2010 17:43:08 -0800 (PST)
In-Reply-To: <20100208103501.GA14210@bicker>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-sparse@vger.kernel.org

On Mon, Feb 8, 2010 at 2:35 AM, Dan Carpenter <error27@gmail.com> wrote=
:
> I've found an issue handling typedefs and alignment. =A0In the append=
ed
> code sparse things 'ptr' has to be aligned so the size of 'bar' is 10=
24.
> I haven't looked at how to fix this at all, I thought I would ask the
> experts for hints first.

Hmm, there is a bug there.

=46or the simplified code:

typedef struct aligned_struct {
       int a;
}  __attribute__ ((aligned(1024))) ali_t;

ali_t *ppr;

running test-parsing will show:

=2Ealign 1024
struct aligned_struct [usertype] *[addressable] [toplevel] ppr

I am looking at it right now.

Chris



>
> regards,
> dan carpenter
>
> #include <stdio.h>
>
> typedef struct aligned_struct {
> =A0 =A0 =A0 =A0int a;
> } =A0__attribute__ ((aligned(1024))) ali_t;
>
> struct foo {
> =A0 =A0 =A0 =A0int b;
> =A0 =A0 =A0 =A0ali_t *ptr;
> };

It does look wrong. The easier way to expose it


>
> int mainx(void)
> {
> =A0 =A0 =A0 =A0struct foo bar;
>
> =A0 =A0 =A0 =A0printf("%d\n", sizeof(bar));
> =A0 =A0 =A0 =A0return 0;
> }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

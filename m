From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Tue, 18 Jul 2017 19:12:17 -0400
Message-ID: <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:32868 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbdGRXMS (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 18 Jul 2017 19:12:18 -0400
Received: by mail-pf0-f181.google.com with SMTP id s70so9083906pfs.0
        for <linux-sparse@vger.kernel.org>; Tue, 18 Jul 2017 16:12:18 -0700 (PDT)
In-Reply-To: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Tue, Jul 18, 2017 at 10:47 AM, Michael Stefaniuc
<mstefani@mykolab.com> wrote:
> Hello guys,
>
> I thought I'll test the new sparse on the Wine source code, especially
> as I remember to have gotten 1-2 of those famous "Crazy programmer" errors.
>
> But I seem to get an infinite loop with a mem leak: 100% CPU with the
> memory utilization increasing until this line triggers
> sparse/allocate.c:105:                 die("out of memory");


OK, I have shrink the test program into the following code.
It can still reproduce the dead loop. It is related to simplify
the phi source.

Unfortunately I need to go now.

Luc, you want to take a look?

Chris

==========================================

extern char *strcpy (char *__dest, const char *__src);

static void test_menu_iteminfo( void )
{
int ansi = 1;
void *init, *string;
char stringA[0x80];
do {
if(ansi)
string=stringA;
if(ansi)
strcpy( string, init );
} while( !(ansi = !ansi) );
}

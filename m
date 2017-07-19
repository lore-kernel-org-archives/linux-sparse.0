From: Michael Stefaniuc <mstefani@mykolab.com>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Wed, 19 Jul 2017 20:50:38 +0200
Message-ID: <3327446f-4ba6-655f-0f3a-31e337e7fd8b@mykolab.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com>
 <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
 <CANeU7Q=aKJ_JHNBAeG_yatjb7hb_S1D5vfHJ72_B3EK-nrutdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx.kolabnow.com ([95.128.36.42]:49434 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754965AbdGSSuw (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 14:50:52 -0400
In-Reply-To: <CANeU7Q=aKJ_JHNBAeG_yatjb7hb_S1D5vfHJ72_B3EK-nrutdg@mail.gmail.com>
Content-Language: en-US
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Hello Chris,

On 07/19/2017 05:25 PM, Christopher Li wrote:
> On Wed, Jul 19, 2017 at 9:26 AM, Christopher Li <sparse@chrisli.org> wrote:
>> I have revert the change cause this problem on sparse-next.
>>
>> Wine compile should be able to complete now.
> 
> Yes, I have single CPU build the wine package to a complete.
> The test sparse is on the sparse-next branch.
make -j12 works fine too. Thanks for the fix.

Btw. I don't see any "crazy programmer" left for Wine.


bye
	michael

> 
> cgcc -o wineserver async.o atom.o change.o class.o clipboard.o
> completion.o console.o debugger.o device.o \
>   directory.o event.o fd.o file.o handle.o hook.o mach.o mailslot.o
> main.o mapping.o mutex.o \
>   named_pipe.o object.o process.o procfs.o ptrace.o queue.o region.o
> registry.o request.o \
>   semaphore.o serial.o signal.o snapshot.o sock.o symlink.o thread.o
> timer.o token.o trace.o \
>   unicode.o user.o window.o winstation.o -Wl,--rpath,\$ORIGIN/../libs/wine \
>   ../libs/port/libwine_port.a -lwine -L../libs/wine
> make[1]: Leaving directory '/home/xxx/git/oss/wine/server'
> Wine build complete.
> 
> Chris
> 


From: Christopher Li <sparse@chrisli.org>
Subject: Re: Infinite loop with OOM while testing Sparse on Wine code
Date: Wed, 19 Jul 2017 11:25:57 -0400
Message-ID: <CANeU7Q=aKJ_JHNBAeG_yatjb7hb_S1D5vfHJ72_B3EK-nrutdg@mail.gmail.com>
References: <a4d23510-5bd4-9d88-f7a8-731882744043@mykolab.com>
 <CANeU7QnEui=yTjf+=TYU89mEhOrOj3b3X_W0csxJJ-eLRokWcg@mail.gmail.com>
 <CANeU7Qk37weXva_-_M4bXeTTAT-DYGcccy+6jYv8pO6gzZNLcA@mail.gmail.com> <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:33279 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754233AbdGSPZ6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 19 Jul 2017 11:25:58 -0400
Received: by mail-pf0-f176.google.com with SMTP id s70so1487909pfs.0
        for <linux-sparse@vger.kernel.org>; Wed, 19 Jul 2017 08:25:58 -0700 (PDT)
In-Reply-To: <CANeU7Qkm_V8cYW3yKKBHo6PY9r0CA+XoTfJCVZbcOS14Am_PiA@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Michael Stefaniuc <mstefani@mykolab.com>
Cc: Sparse Mailing-list <linux-sparse@vger.kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

On Wed, Jul 19, 2017 at 9:26 AM, Christopher Li <sparse@chrisli.org> wrote:
> I have revert the change cause this problem on sparse-next.
>
> Wine compile should be able to complete now.

Yes, I have single CPU build the wine package to a complete.
The test sparse is on the sparse-next branch.

cgcc -o wineserver async.o atom.o change.o class.o clipboard.o
completion.o console.o debugger.o device.o \
  directory.o event.o fd.o file.o handle.o hook.o mach.o mailslot.o
main.o mapping.o mutex.o \
  named_pipe.o object.o process.o procfs.o ptrace.o queue.o region.o
registry.o request.o \
  semaphore.o serial.o signal.o snapshot.o sock.o symlink.o thread.o
timer.o token.o trace.o \
  unicode.o user.o window.o winstation.o -Wl,--rpath,\$ORIGIN/../libs/wine \
  ../libs/port/libwine_port.a -lwine -L../libs/wine
make[1]: Leaving directory '/home/xxx/git/oss/wine/server'
Wine build complete.

Chris

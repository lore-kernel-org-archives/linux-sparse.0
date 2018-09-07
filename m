From: Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: Conflict between sparse and commit cafa0010cd51f ("Raise the
 minimum required gcc version to 4.6")
Date: Fri, 7 Sep 2018 16:33:58 +0200
Message-ID: <1324e7d6-83f8-f40f-ad34-c46e4ad3139b@c-s.fr>
References: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81a5fd11-366c-0897-4143-d8d041420a41@c-s.fr>
Content-Language: fr
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, Kees Cook <keescook@chromium.org>, Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org

Cc linux-sparse@vger.kernel.org

Le 07/09/2018 à 14:22, Christophe Leroy a écrit :
> Since commit cafa0010cd51f ("Raise the minimum required gcc version to 
> 4.6"), sparse check fails as follows:
> 
> [root@pc16082vm linux-powerpc]# make C=2 arch/powerpc/kernel/process.o
>    CALL    scripts/checksyscalls.sh
>    CHECK   scripts/mod/empty.c
> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too 
> old - please upgrade it.
>    CHECK   arch/powerpc/kernel/process.c
> ./include/linux/compiler-gcc.h:14:3: error: Sorry, your compiler is too 
> old - please upgrade it.
> 
> 
> I have sparse version 0.5.2
> 
> What can be done to fix that ?
> 
> Christophe

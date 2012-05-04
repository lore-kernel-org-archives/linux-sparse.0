From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 14:36:40 +0200
Message-ID: <4FA3CD58.80809@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:34213 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757796Ab2EDMdL (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 08:33:11 -0400
Received: by lbbgm6 with SMTP id gm6so1978351lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 05:33:09 -0700 (PDT)
In-Reply-To: <4FA3B14A.3070609@gaisler.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Konrad Eisele <konrad@gaisler.com>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

>>
>> No, that would be a no go. I don't mind allow dependence program
>> have the option to keep the token around. However, for other C back
>> ends, the token serve no purpose. It just sit there waste memory. So
>> I don't want the token become mandatory.
>

Ok, one more try:
   Your question is: Why is is meaningful to
   have tokens saved even in the parse stage.
I tried to come up with some meaningful example.

Take the 2 files b.c and a.h.

vvvvvv b.c vvvvv
#define d1
#include "a.h"
struct s0 { int x; };
int main(int a, char **b) {
   struct s0 v;
   d2(m);
};
^^^^^^ b.c ^^^^^^

vvvvvv a.h vvvvv
#ifdef d2
#define m v
#else
#define m n
#endif

#ifdef d1
#define d2(a) while(a.x) { }
#endif
^^^^^^ a.h ^^^^^^

Now use sparse and you get:
$./sparse b.c
b.c:6:3: error: cannot dereference this type

The error was that you forgot in b.c:
+#define d2
  #define d1
  ...

When you have a dependency tree what you can printout is:

$./sparse b.c
b.c:6:3: error: cannot dereference this type
  +macro expansion of d2 defined in a.h:8
    + defined because of #ifdef d1 in a.h:7
     + dependent of d1 defined at b.c:1
  +> argument 0 expansion at b.c:6
    + macro expansion m defined in a.h:4
      + defined because of else of #ifdef d2
        + dependend of d2 (not defined)

Or you can print it out human readable:

$./sparse b.c
b.c:6:3: error: cannot dereference this type
#define d1
#include "a.h"
  #ifdef d2
  #else
  #define m n
  #endif
  #ifdef d1
  #define d2(a) while(a.x) { }
  #endif

I've improviced a bit, the "human readable" ouput
is the whole of a.h and b.c because there is
no nondependent part to strip...

Now tell me that this is not useful and this is the
last post on this subject. Dont you think that gcc's
...
  In file included from ./b.c:3:0:
  In file included from ./x.c13:0:
...
is useful? With macro dependency saved you can
printout all.

-- Konrad





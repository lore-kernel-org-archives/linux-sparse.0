From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [Bug 207959] New: Don't warn about the universal zero initializer
 for a structure with the 'designated_init' attribute.
Date: Thu, 28 May 2020 20:57:40 +0100
Message-ID: <90ad9ce9-fcbc-7018-3c1f-243602e49dd7@ramsayjones.plus.com>
References: <bug-207959-200559@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from avasout07.plus.net ([84.93.230.235]:48561 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406687AbgE1T5v (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 28 May 2020 15:57:51 -0400
In-Reply-To: <bug-207959-200559@https.bugzilla.kernel.org/>
Content-Language: en-GB
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: AsDaGo@posteo.net



On 28/05/2020 17:27, bugzilla-daemon@bugzilla.kernel.org wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=207959
> 
>             Bug ID: 207959
>            Summary: Don't warn about the universal zero initializer for a
>                     structure with the 'designated_init' attribute.
>            Product: Tools
>            Version: unspecified
>     Kernel Version: Sparse 0.6.1 (Debian: 0.6.1-2+b1)
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: enhancement
>           Priority: P1
>          Component: Sparse
>           Assignee: tools_sparse@kernel-bugs.kernel.org
>           Reporter: AsDaGo@posteo.net
>         Regression: No
> 
> Created attachment 289383
>   --> https://bugzilla.kernel.org/attachment.cgi?id=289383&action=edit
> A test program illustrating the issue
> 
> I reported this bug to GCC here:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=95379
> 
> They don't want to diverge GCC's behavior from Sparse's, but I think this would
> be a useful feature, and I think it should be implemented in Sparse as well.
> Below is my bug report to GCC.
> 
>> When the 'designated_init' attribute is used on a structure type, GCC warns
>> when an instance of that structure is initialized with '{ 0 }'. I think GCC
>> should make an exception for this, since '{ 0 }' is often used to initialize
>> all fields of a structure to 0, and it does not depend on the internal
>> structure of the structure type.
>>
>> If '{ }' is used to initialize the structure, GCC does not warn. However,
>> although '{ }' seems to initialize the structure to zero in GCC, I'm not
>> sure if it's as portable as '{ 0 }' (and it's less readable, IMO). I think
>> '{ }' is part of the C++ standard; does anyone know if it's part of C too?

No this is not standard C:

  $ cat -n junk1.c
       1	#include <stdio.h>
       2	
       3	int main (int argc, char *argv[])
       4	{
       5		struct { char *f; int i; } fred = {};
       6		printf("fred.f %p, fred.i %d\n", fred.f, fred.i);
       7		return 0;	
       8	}
  $ gcc -pedantic -o junk1 junk1.c
  junk1.c: In function ‘main’:
  junk1.c:5:36: warning: ISO C forbids empty initializer braces [-Wpedantic]
    struct { char *f; int i; } fred = {};
                                      ^
  $ ./junk1
  fred.f (nil), fred.i 0
  $ 

... and you get similar results with clang:

  $ clang -pedantic -o junk1 junk1.c
  junk1.c:5:36: warning: use of GNU empty initializer extension
        [-Wgnu-empty-initializer]
          struct { char *f; int i; } fred = {};
                                            ^
  junk1.c:6:35: warning: format specifies type 'void *' but the argument has type
        'char *' [-Wformat-pedantic]
          printf("fred.f %p, fred.i %d\n", fred.f, fred.i);
                         ~~                ^~~~~~
                         %s
  2 warnings generated.
  $ 
  

ATB,
Ramsay Jones


  

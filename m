From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 22:53:52 +0200
Message-ID: <4FA441E0.6010701@gmail.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <4FA3CD58.80809@gmail.com> <20120504153054.GA5994@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:37614 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759883Ab2EDUuY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 16:50:24 -0400
Received: by lbbgm6 with SMTP id gm6so2320679lbb.19
        for <linux-sparse@vger.kernel.org>; Fri, 04 May 2012 13:50:22 -0700 (PDT)
In-Reply-To: <20120504153054.GA5994@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Konrad Eisele <konrad@gaisler.com>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On 05/04/2012 05:30 PM, Josh Triplett wrote:
> On Fri, May 04, 2012 at 02:36:40PM +0200, Konrad Eisele wrote:
>> Take the 2 files b.c and a.h.
>>
>> vvvvvv b.c vvvvv
>> #define d1
>> #include "a.h"
>> struct s0 { int x; };
>> int main(int a, char **b) {
>>    struct s0 v;
>>    d2(m);
>> };
>> ^^^^^^ b.c ^^^^^^
>>
>> vvvvvv a.h vvvvv
>> #ifdef d2
>> #define m v
>> #else
>> #define m n
>> #endif
>>
>> #ifdef d1
>> #define d2(a) while(a.x) { }
>> #endif
>> ^^^^^^ a.h ^^^^^^
>>
>> Now use sparse and you get:
>> $./sparse b.c
>> b.c:6:3: error: cannot dereference this type
>>
>> The error was that you forgot in b.c:
>> +#define d2
>>   #define d1
>>   ...
>>
>> When you have a dependency tree what you can printout is:
>>
>> $./sparse b.c
>> b.c:6:3: error: cannot dereference this type
>>   +macro expansion of d2 defined in a.h:8
>>     + defined because of #ifdef d1 in a.h:7
>>      + dependent of d1 defined at b.c:1
>>   +>  argument 0 expansion at b.c:6
>>     + macro expansion m defined in a.h:4
>>       + defined because of else of #ifdef d2
>>         + dependend of d2 (not defined)
>
> That looks wildly useful to me.  I'd love to see that information
> available to Sparse somehow, as long as it doesn't significantly impact
> the performance of the common case (namely, running sparse on code that
> has no warnings or errors).
>
> One idea: could you check the impact of your patch on a Linux kernel
> build (with defconfig)?  Try building the kernel with sparse (make C=2),
> with and without your patch, and measure the total time.  If your patch
> has negligible impact on build time, and it doesn't require changing
> every other line of Sparse due to interface changes, it should prove
> reasonable.

make C=2:

original sparse:
real    17m54.997s
user    15m25.181s
sys     2m11.281s

decpp-sparse from "git clone git://git.code.sf.net/p/decpp/code decpp "
real    18m29.748s
user    16m18.155s
sys     2m13.221s

But decpp is not written with performance in common cases in mind.
The 2 runs probably also depend on other factors too.
I cant think that 4 bytes extra for each token can have a big impact,
if I would implement it that way (it is not in decpp).

>
> The other key point: much like Linux, Sparse doesn't normally accept
> patches that add a new interface without a patch adding the
> corresponding code that uses that interface.  Having an implementation
> helps ensure that the design of an interface fits its intended purpose.
> For instance, if you could create a simple example of the kind of output
> you showed above (even just saying in a warning message "expanded from
> macro foo"), perhaps modeled after LLVM's clang error messages, and
> include that in a second patch depending on the first, then that
> two-patch sequence would have a much better chance of getting in.

I understand. Actually the code to demonstrate is
git://git.code.sf.net/p/decpp/code , then do a
$make
$./shrinkc t1.c
That is kind of the goal.
And - it does require some  internal structure
change. You dont get this kind of functionality
for free. You have to be invasive, isnt this
something that is obvious?. And in my view, it
can come with penalty. The preprocessing stage
is not something that should be neglected all
the time as if not existent. You struggle
with Macros half of the time you program.


-- Konrad


>
> Hope that helps,
> Josh Triplett
>


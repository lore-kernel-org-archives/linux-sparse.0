From: Konrad Eisele <eiselekd@gmail.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Wed, 2 May 2012 09:27:26 +0200
Message-ID: <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46398 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754135Ab2EBH12 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 May 2012 03:27:28 -0400
Received: by eekc41 with SMTP id c41so64700eek.19
        for <linux-sparse@vger.kernel.org>; Wed, 02 May 2012 00:27:26 -0700 (PDT)
In-Reply-To: <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <konrad@gaisler.com>, linux-sparse@vger.kernel.org

2012/5/1 Christopher Li <sparse@chrisli.org>:
> On Tue, Apr 24, 2012 at 2:54 AM, Konrad Eisele <konrad@gaisler.com> w=
rote:
>> Hi, I'd like to extend sparse so that I can preserve a
>> dependency tree that goes from c parse entities all
>> the way down to single tokens. There are several places
>> this can be useful:
>
> Sorry for the delay. I take a some time to think about this problem.
>
> May I ask some high level questions? I am trying to understand why
> this this token level dependency is useful. One alternative is that,
> you do a per-processor stage on the source file. Then you have one
> big post processed source. The current sparse can run on that process=
ed
> source file and get all the symbol dependency.
>
> Because each symbol has "pos" and "endpos" member. You only need
> to recursively walk the ctype of the symbols you can get the shrink v=
ersion
> of the source code. The draw back with that is, all the macro has bee=
n
> expended, you will not able to see the macro names etc.

But this is the point. All macros are expanded. They disappear complete=
ly in
the pre-processing step. There is no tool at all right now that
preserves the macro-dependency. Even in IDEs like Eclipse you have tool=
s to show
macros expansions, but you have no tool to show you in a simple
way for i.e.:
#define a
#ifdef a
#define b 1
#endif
that "#define b 1" is dependent of "#define a" even the "#ifdef a" is
lost and you have to deduce it yourself from the #line comments.

I think not very many people know really how (not where) i.e. "size_t" =
gets
defined. There are too many "#ifdef" cases around, too many
#include.



>
> Also, if you change the source file, the shrinking process has to be =
redone
> because it might use new macros. So the shrinking + compiling is not
> necessary a saving compare to directly compiling without the shrinkin=
g.
> I figure you might have a slightly different usage module in mind to =
justify
> the shrinking. Please help me understand how you intend to use it.

Yes that is true. Still, for a fixed configuration in most cases you
can achieve a speedup. Also you would have a tool to really benchmark
source that doesnt draw in too much dependency.

>
> I think if the source file doesn't need pre-processing. Sparse can do=
 symbol
> dependency already. What you really want is actually being able to ba=
ck
> trace in the pre-processing stage, what macro has been expand and wha=
t
> is the original form on the expanded value.

The information for this is in "struct macro_expansion" of the patch an=
d one can
build aroung it a trace of the macro expansion. I've done that with a p=
atch for
gcc and could do it for sparse also. A example is at:
http://cfw.sourceforge.net/htmltag/init_32.c.pinfo.html
source at : http://cfw.sourceforge.net/htmltags.html
i.e. go in init_32.c.pinfo.html to mark_rodata_ro() and click on
virt_to_page (). A help in in the left pannel.

-- Konrad


>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spars=
e" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-sparse"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

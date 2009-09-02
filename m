From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Tue, 1 Sep 2009 17:27:08 -0700
Message-ID: <20090901172708.286657ec@nehalam>
References: <20090830153202.4dc5c58c@s6510>
	<200908312104.54990.kdudka@redhat.com>
	<20090831205353.GA6239@josh-work.beaverton.ibm.com>
	<200909012359.09678.kdudka@redhat.com>
	<20090901232433.GC3947@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:33920 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752118AbZIBA1M (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Sep 2009 20:27:12 -0400
In-Reply-To: <20090901232433.GC3947@josh-work.beaverton.ibm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Kamil Dudka <kdudka@redhat.com>, linux-sparse@vger.kernel.org

On Tue, 1 Sep 2009 16:24:33 -0700
Josh Triplett <josh@joshtriplett.org> wrote:

> On Tue, Sep 01, 2009 at 11:59:09PM +0200, Kamil Dudka wrote:
> > On Monday 31 of August 2009 22:53:54 Josh Triplett wrote:
> > > That seems quite sensible, and it even seems like something sparse
> > > should warn about by default.
> > >
> > > The reverse, warning about the assignment of an enum value to int, seems
> > > useful as well, but sparse shouldn't issue that warning by default
> > > because a lot of code just uses enum to define constants.
> > >
> > > Distinguishing between anonymous and named enums seems useful as well.
> > > An anonymous enum just creates some named constants but doesn't create a
> > > type to use them with, so assigning those constants to int shouldn't
> > > generate a warning.  (Corner case: "enum { ... } foo;".)
> > 
> > Here is my first take at casting from/to enum along with a simple test case. 
> > Any feedback welcome...
> 
> Thanks for writing the patch.  This looks really good so far.  I have a
> couple of comments on the cases you warn about and how you classify the
> warnings:
> 
> > static void foo(void) {
> >     enum ENUM_TYPE_A { VALUE_A } var_a;
> >     enum ENUM_TYPE_B { VALUE_B } var_b;
> >     enum /* anon. */ { VALUE_C } anon_enum_var;
> >     int i;
> > 
> >     // always OK
> >     var_a = VALUE_A;
> >     var_a = (enum ENUM_TYPE_A) VALUE_B;
> >     var_b = (enum ENUM_TYPE_B) i;
> >     i = (int) VALUE_A;
> 
> Fair enough; a cast should indeed make the warning go away.  Good catch
> to include the case of casting an enum value to a different enum type.
> I'd also suggest including some casts of values like 0 in the "always
> OK" section:
> 
>     var_a = (enum ENUM_TYPE_B) 0;
> 
> >     i = VALUE_B;
> 
> Why does this not generate a warning with Wenum-to-int?  You should have
> to cast VALUE_B to int.
> 
> >     anon_enum_var = VALUE_C;
> >     i = VALUE_C;
> >     i = anon_enum_var;
> 
> Excellent, this represents exactly the behavior I had in mind when I
> suggested the anonymous enum issue.
> 
> >     // already caught by -Wenum-mismatch (default)
> >     var_a = var_b;
> >     var_b = anon_enum_var;
> >     anon_enum_var = var_a;
> > 
> >     // caught by -Wint-to-enum (default)
> >     var_a = VALUE_B;
> >     var_b = VALUE_C;
> >     anon_enum_var = VALUE_A;
> 
> Why does Wenum-mismatch not catch these?  Because it treats those
> constants as ints?  Regardless of the cause, this seems wrong.  If you
> explicitly declare a variable with enum type, assigning the wrong enum
> constant to it should generate a enum-mismatch warning, not an
> int-to-enum warning.  However, I understand if this proves hard to fix,
> and generating *some* warning seems like an improvement over the current
> behavior of generating *no* warning.
> 
> >     var_a = 0;
> >     var_b = i;
> >     anon_enum_var = 0;
> >     anon_enum_var = i;
> 
> I'd also suggest including tests with enum constants casted to integers:
> 
>     var_a = (int) VALUE_A;
>     var_a = (int) VALUE_B;
> 
> >     // caught only with -Wenum-to-int
> >     i = var_a;
> > }
> 
> > --- a/sparse.1
> > +++ b/sparse.1
> > @@ -149,6 +149,18 @@ Sparse issues these warnings by default.  To turn them off, use
> >  \fB\-Wno\-enum\-mismatch\fR.
> >  .
> >  .TP
> > +.B \-Wenum\-to\-int
> > +Warn about casting of an \fBenum\fR type to int and thus possible lost of
> > +information about the type.
> 
> This should not say "warn about casting", because it specifically
> *doesn't* warn about casting.  s/casting of/converting/.
> 
> I don't think "possible loss of information" seems like the reason to
> care about this warning.  These warnings just represent ways of getting
> sparse to make you treat enums as distinct types from int.  I'd suggest
> dropping the second half of the sentence.
> 
> I'd also suggest adding something like "An explicit cast to int will
> suppress this warning.".
> 
> > +.TP
> > +.B \-Wint\-to\-enum
> > +Warn about casting of int (or incompatible enumeration constant) to \fBenum\fR.
> 
> OK, so the test represents *documented* behavior, but it still doesn't
> seem right. :)  The "(or incompatible enumeration constant)" bit seems
> like it should become part of Wenum-mismatch.
> 
> Or if necessary, perhaps part of some new flag, like
> Wenum-constant-mismatch, but that seems like overkill.
> 
> s/casting of/converting/, as above.
> 
> I'd also suggest adding "An explicit cast to the enum type will suppress
> this warning.".
> 
> - Josh Triplett


there is lots of code that does:

enum {
   my_register_1   = 0x001,
   my_register_2   = 0x002,
};


foo(void) {
   write_register(my_register_1, SETUP_VAL_X);
...

So going from enum to int must be optional, but int to enum should
trigger a warning.

I'll give it a pass on the kernel for giggles.





-- 

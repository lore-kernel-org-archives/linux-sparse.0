From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Wed, 2 Sep 2009 08:21:46 -0700
Message-ID: <20090902152146.GA7881@feather>
References: <20090830153202.4dc5c58c@s6510>
 <200909012359.09678.kdudka@redhat.com>
 <20090901232433.GC3947@josh-work.beaverton.ibm.com>
 <200909021353.17091.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from relay1-v.mail.gandi.net ([217.70.178.75]:45022 "EHLO
	relay1-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752356AbZIBPV6 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Sep 2009 11:21:58 -0400
Content-Disposition: inline
In-Reply-To: <200909021353.17091.kdudka@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Kamil Dudka <kdudka@redhat.com>
Cc: Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org

On Wed, Sep 02, 2009 at 01:53:17PM +0200, Kamil Dudka wrote:
> Well, let's go for the second iteration...
> 
> On Wed September 2 2009 01:24:33 Josh Triplett wrote:
> > warnings:
> > > static void foo(void) {
> > >     enum ENUM_TYPE_A { VALUE_A } var_a;
> > >     enum ENUM_TYPE_B { VALUE_B } var_b;
> > >     enum /* anon. */ { VALUE_C } anon_enum_var;
> > >     int i;
> > >
> > >     // always OK
> > >     var_a = VALUE_A;
> > >     var_a = (enum ENUM_TYPE_A) VALUE_B;
> > >     var_b = (enum ENUM_TYPE_B) i;
> > >     i = (int) VALUE_A;
> >
> > Fair enough; a cast should indeed make the warning go away.  Good catch
> > to include the case of casting an enum value to a different enum type.
> > I'd also suggest including some casts of values like 0 in the "always
> > OK" section:
> >
> >     var_a = (enum ENUM_TYPE_B) 0;
> 
> This is IMO not "always OK":
> warning: mixing different enum types
>     int enum ENUM_TYPE_B  versus
>     int enum ENUM_TYPE_A
> 
> Why should we have an exception for zero? Then we would not distinguish 
> between VALUE_A and VALUE_B? This needs some justification. Have you 
> considered the case that zero is even not valid at all for an enum?

Typo.  I meant ENUM_TYPE_A:

    var_a = (enum ENUM_TYPE_A) 0;

Hopefully that makes more sense as an "always OK" test. :)

Another crazy test for the "always OK" section:

    anon_enum_var = (__typeof__(anon_enum_var)) 0;
    anon_enum_var = (__typeof__(anon_enum_var)) VALUE_A;

> > >     i = VALUE_B;
> >
> > Why does this not generate a warning with Wenum-to-int?  You should have
> > to cast VALUE_B to int.
> 
> I was not sure if this is actually useful ... now it does.

Thanks!  Yes, this seems very useful to me as a part of Wenum-to-int.

> > >     // caught by -Wint-to-enum (default)
> > >     var_a = VALUE_B;
> > >     var_b = VALUE_C;
> > >     anon_enum_var = VALUE_A;
> >
> > Why does Wenum-mismatch not catch these?  Because it treats those
> > constants as ints?  Regardless of the cause, this seems wrong.  If you
> > explicitly declare a variable with enum type, assigning the wrong enum
> > constant to it should generate a enum-mismatch warning, not an
> 
> Well, now caught by -Wenum-mismatch instead.
> 
> > int-to-enum warning.  However, I understand if this proves hard to fix,
> > and generating *some* warning seems like an improvement over the current
> > behavior of generating *no* warning.
> 
> Nope, it's easy to fix if you don't care about the change in behavior
> of -Wenum-mismatch.

Excellent!  This seems like fixing a deficiency in -Wenum-mismatch: it
should warn about using the wrong enum type with an enum value.  When
you use an enum type instead of int, you should use the *right* enum
type.  :)

Thanks for making this change.

> > >     var_a = 0;
> > >     var_b = i;
> > >     anon_enum_var = 0;
> > >     anon_enum_var = i;
> >
> > I'd also suggest including tests with enum constants casted to integers:
> >
> >     var_a = (int) VALUE_A;
> >     var_a = (int) VALUE_B;
> 
> Added.

Thanks; this should help prevent strange corner-case regressions in the
future.

> > > --- a/sparse.1
> > > +++ b/sparse.1
> > > @@ -149,6 +149,18 @@ Sparse issues these warnings by default.  To turn
> > > them off, use \fB\-Wno\-enum\-mismatch\fR.
> > >  .
> > >  .TP
> > > +.B \-Wenum\-to\-int
> > > +Warn about casting of an \fBenum\fR type to int and thus possible lost
> > > of +information about the type.
> >
> > This should not say "warn about casting", because it specifically
> > *doesn't* warn about casting.  s/casting of/converting/.
> >
> > I don't think "possible loss of information" seems like the reason to
> > care about this warning.  These warnings just represent ways of getting
> > sparse to make you treat enums as distinct types from int.  I'd suggest
> > dropping the second half of the sentence.
> >
> > I'd also suggest adding something like "An explicit cast to int will
> > suppress this warning.".
> 
> Fixed.
> 
> > > +.TP
> > > +.B \-Wint\-to\-enum
> > > +Warn about casting of int (or incompatible enumeration constant) to
> > > \fBenum\fR.
> >
> > OK, so the test represents *documented* behavior, but it still doesn't
> > seem right. :)  The "(or incompatible enumeration constant)" bit seems
> > like it should become part of Wenum-mismatch.
> >
> > Or if necessary, perhaps part of some new flag, like
> > Wenum-constant-mismatch, but that seems like overkill.
> >
> > s/casting of/converting/, as above.
> >
> > I'd also suggest adding "An explicit cast to the enum type will suppress
> > this warning.".
> 
> Fixed.
> 
> I would really appreciate some native (or native like) speaker willing to 
> reword my man page attempts completely. Any volunteer around? :-)

I tried to do so above; the changes I suggested (which you incorporated)
represented my attempt at rewording for clarity.

> +static void
> +warn_for_enum_to_int_cast (struct expression *expr, struct symbol *typeb)
> +{
[...]
> +}
> +
> +static void
> +warn_for_int_to_enum_cast (struct expression *expr, struct symbol *typeb)
> +{
[...]
> +}
> +
>  /*
>   * This gets called for implicit casts in assignments and
>   * integer promotion. We often want to try to move the
> @@ -267,7 +334,10 @@ static struct expression * cast_to(struct expression *old, struct symbol *type)
>  {
>  	struct expression *expr;
>  
> -	warn_for_different_enum_types (old->pos, old->ctype, type);
> +	warn_for_different_enum_types (old->pos, old->ctype, type,
> +				       old->enum_type);

At this point, it might make more sense to just pass old, rather than
three of its fields.  Would that work for the other callers of this
function?  In any case, that change can wait until after this patch.

> +	warn_for_enum_to_int_cast (old, type);
> +	warn_for_int_to_enum_cast (old, type);

I just realized that both of these functions need renaming as well:
s/cast/conversion/ or similar.  As with the manpage changes before,
"cast" describes the case it *doesn't* warn about.

> --- a/sparse.1
> +++ b/sparse.1
> @@ -149,6 +149,19 @@ Sparse issues these warnings by default.  To turn them off, use
>  \fB\-Wno\-enum\-mismatch\fR.
>  .
>  .TP
> +.B \-Wenum\-to\-int
> +Warn about converting an \fBenum\fR type to int. An explicit cast to int will
> +suppress this warning.
> +.
> +.TP
> +.B \-Wint\-to\-enum
> +Warn about converting int to \fBenum\fR type. An explicit cast to the right
> +\fBenum\fR type will suppress this warning.
> +
> +Sparse issues these warnings by default.  To turn them off, use
> +\fB\-Wno\-int\-to\-enum\fR.

This manpage text looks good to me.

> static void foo(void) {
>     enum ENUM_TYPE_A { VALUE_A } var_a;
>     enum ENUM_TYPE_B { VALUE_B } var_b;
>     enum /* anon. */ { VALUE_C } anon_enum_var;
>     int i;
> 
>     // always OK
>     var_a = VALUE_A;
>     var_a = (enum ENUM_TYPE_A) VALUE_B;
>     var_b = (enum ENUM_TYPE_B) i;
>     i = (int) VALUE_A;
>     anon_enum_var = VALUE_C;
>     i = VALUE_C;
>     i = anon_enum_var;
>     i = 7;
> 
>     // caught by -Wenum-mismatch (default) even without the patch
>     var_a = var_b;
>     var_b = anon_enum_var;
>     anon_enum_var = var_a;
>     var_a = (enum ENUM_TYPE_B) 0;
> 
>     // caught by -Wenum-mismatch (default) only with the patch applied
>     var_a = VALUE_B;
>     var_b = VALUE_C;
>     anon_enum_var = VALUE_A;
> 
>     // caught by -Wint-to-enum (default)
>     var_a = 0;
>     var_b = i;
>     anon_enum_var = 0;
>     anon_enum_var = i;
>     var_a = (int) VALUE_A;
>     var_a = (int) VALUE_B;
> 
>     // caught only with -Wenum-to-int
>     i = var_a;
>     i = VALUE_B;
> }

You could include this test case in the patch, as an addition to the
test suite.

- Josh Triplett

From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: including sparse headers in C++ code
Date: Tue, 19 Oct 2010 22:31:09 +0100
Message-ID: <20101019213109.GV19804@ZenIV.linux.org.uk>
References: <20101011224656.GN19804@ZenIV.linux.org.uk>
 <AANLkTinWYFf0CqBt9FJ9QyeGCU6754GotQM06U4vMqRa@mail.gmail.com>
 <AANLkTimdy9TwwSJM=rwTjXdRsnove6A2b0=d4M_dOin0@mail.gmail.com>
 <AANLkTimhh3zj8kgvaSQq9_CS711mLw8skrWL4yUgvJzT@mail.gmail.com>
 <AANLkTimZb1PsnKcMQ_Ka6dkk7fNwXiJb6_U4GcckLsF4@mail.gmail.com>
 <20101016191153.GA19324@feather>
 <AANLkTi=tpKLvWh6VKsizpZaxYMBntaGU1gC5uRu1_bND@mail.gmail.com>
 <20101018053955.GA1628@feather>
 <AANLkTim2ti8+aht_f=Mv=0iLZCvF65CFF6GNP2gHF=Kq@mail.gmail.com>
 <AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:47880 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754490Ab0JSVbO (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 19 Oct 2010 17:31:14 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinuRiaMZExudng5ECeunmF4s2ptnfaE=fYBft=i@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Tomas Klacko <tomas.klacko@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Tue, Oct 19, 2010 at 10:03:42PM +0200, Tomas Klacko wrote:
> @@ -188,7 +188,7 @@ static struct symbol_op char_op = {
>  	.type = KW_SPECIFIER,
>  	.test = Set_T|Set_Long|Set_Short,
>  	.set = Set_T|Set_Char,
> -	.class = CChar,
> +	.klass = CChar,
>  };

Egads...  Why not "kC1455", while you are at it?  Seriously, if you feel the
need to rename that, at least use something more palatable.  Hell, even
adjust_type would be better...

The only thing using that field is parsing of declaration specifiers.  We
keep track of what's acceptable after the prefix we'd seen (and report
conflicts).  We remember if we'd seen a speficier that doesn't combine with
anything (struct/union/enum/void/_Bool/typeof/__builtin_va_list) and for
numeric ones we are using a bit of trick: assign them pairs of integers as
below and add those up.
	int: (0,0)
	short: (-1,0)
	long: (1,0)
	signed: (0,1)
	unsigned: (0,2)
	double: (0, 3)
	float: (-1, 3)
	char: (0, 4)
Then the sum will be sufficient to discriminate between the resulting types
of acceptable sequences of numeric specifiers.  Namely, if the sum is (s,t),
the type we have is
   |  s = -1          |  0          |  1              |  2                   |
t=0|short int         |int          |long int         |long long int         |
t=1|short signed int  |signed int   |long signed int  |long long signed int  |
t=2|short unsigned int|unsigned int |long unsigned int|long long unsigned int|
t=3|float             |double       |long double      |                      |
t=4|                  |char         |                 |                      |
t=5|                  |signed char  |                 |                      |
t=6|                  |unsigned char|                 |                      |
and neither reordering the sequence nor omitting int affect the sum.

The first component of pair is encoded in ->type (KW_SHORT and KW_LONG bits),
the second is stored in ->class.  ->test and ->set drive the rejection of
unacceptable sequences.  For the sake of completeness, meanings of the bits
in these are:
Set_T		seen int/char/double/float/any non-combinable
Set_S		seen any non-combinable
Set_{Char,Int,Double,Float,Signed,Unsigned,Short,Long}	obvious
Set_Vlong	seen either long twice or both long and double
We could conflate e.g. Set_Signed with Set_Unsigned, but we'd have harder
time generating error messages that way.  ->test is "reject if we'd already
seen..." and ->set is "we've just seen...".  The only things not covered by
the above are
	* double long and long double are OK, but triple long and long long
double should be rejected
	* if we'd already seen any type specifiers by the time we run into
a typedef name, the sequence ends just before that typedef name (i.e.
typedef char T; int f(long T) is OK and declares f as int(long int)).
That's it...

>  static inline int match_op(struct token *token, int op)
>  {
> -	return token->pos.type == TOKEN_SPECIAL && token->special == op;
> +	return token->pos.type == TOKEN_SPECIAL && token->special == (unsigned int)op;

What was that one for?

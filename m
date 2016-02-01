From: Nicolai Stange <nicstange@gmail.com>
Subject: Re: [PATCH v2 09/13] expression: examine constness of __builtin_offsetof at evaluation only
Date: Mon, 01 Feb 2016 04:06:49 +0100
Message-ID: <87twltf7sm.fsf@gmail.com>
References: <87twm1g1go.fsf@gmail.com> <87r3h5eman.fsf@gmail.com>
	<20160126015708.GG46188@macpro.local>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35848 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752738AbcBADGw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sun, 31 Jan 2016 22:06:52 -0500
Received: by mail-wm0-f67.google.com with SMTP id 128so7086943wmz.3
        for <linux-sparse@vger.kernel.org>; Sun, 31 Jan 2016 19:06:52 -0800 (PST)
In-Reply-To: <20160126015708.GG46188@macpro.local> (Luc Van Oostenryck's
	message of "Tue, 26 Jan 2016 02:57:09 +0100")
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nicolai Stange <nicstange@gmail.com>, linux-sparse@vger.kernel.org, Christopher Li <sparse@chrisli.org>, Josh Triplett <josh@joshtriplett.org>

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> On Mon, Jan 25, 2016 at 04:00:48PM +0100, Nicolai Stange wrote:
>> Currently, the determination of a __builtin_offsetof() expressions'
>> constness flags is done in two steps:
>> - Several flags are speculatively set at expression parsing time
>> - and possibly cleared again at evaluation if the member expression
>>   includes a non-const array index like in
>>     __builtin_offsetof(struct A, a.b[non_const_foo])
>> 
>> For consistency with other expression types' evaluation, defer the
>> determination of a __builtin_offsetof() expression's constness to
>> evaluation time, too.
>> 
>> Furthermore, carry an array index expression's constness flags
>> through the implicit cast to size_t type.
>
> Better to split this into two patches.
>  
>> @@ -3028,13 +3026,18 @@ static struct symbol *evaluate_offsetof(struct expression *expr)
>>  		} else {
>>  			struct expression *idx = expr->index, *m;
>>  			struct symbol *i_type = evaluate_expression(idx);
>> +			unsigned old_idx_flags;
>>  			int i_class = classify_type(i_type, &i_type);
>> +
>>  			if (!is_int(i_class)) {
>>  				expression_error(expr, "non-integer index");
>>  				return NULL;
>>  			}
>>  			unrestrict(idx, i_class, &i_type);
>> +			old_idx_flags = idx->flags;
>>  			idx = cast_to(idx, size_t_ctype);
>> +			idx->flags |= old_idx_flags;
>> +			expr_flags_decay_consts(&idx->flags);
>>  			m = alloc_const_expression(expr->pos,
>>  						   bits_to_bytes(ctype->bit_size));
>>  			m->ctype = size_t_ctype;
>
> It's not clear at all to me why this is needed.
> Why cast_to() can't set itself the right value for idx->flags?

cast_to() is for implicit casts and to be honest, I don't know what the
->flags should be set to.

Also, this is the only place in the whole code where preserving the
flags over a cast_to() call is needed.

Furthermore, we could get rid of the flags' save and restore by moving
the calculation of expr->flags in front of the cast_to() invocation --
all other cast_to() actually do it this way.

However, I think, it's better to have the assignment to expr->flags
grouped with the rest of the assignments to expr's members.

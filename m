From: Konrad Eisele <konrad@gaisler.com>
Subject: Re: dependency tee from c parser entities downto token
Date: Fri, 04 May 2012 12:36:58 +0200
Message-ID: <4FA3B14A.3070609@gaisler.com>
References: <4F967865.60809@gaisler.com> <CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail201c2.megamailservers.com ([69.49.111.102]:39809 "EHLO
	mail201c2.megamailservers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754238Ab2EDKrB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 4 May 2012 06:47:01 -0400
In-Reply-To: <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <eiselekd@gmail.com>, linux-sparse@vger.kernel.org

Christopher Li wrote:
> On Fri, May 4, 2012 at 12:33 AM, Konrad Eisele<konrad@gaisler.com>  wrote:
>>> I agree this is useful. However I feel the original patch is a bit
>>> invasive.
>>> How about do it in a step by step way. Make a small patch to allow
>>> register
>>> call backs when the macro expands. That way the application using sparse
>>> get notify of the pre-processor macro expands. I can take a look at how to
>>> implement this small patch as well.
>>>
>>> If needed, we can make one option that pre-processor don't free the
>>> tokens.
>>> In this case, very few changes in the caller side. I feel it cleaner
>>> than changing
>>> the free function behavior.
>>
>>
>> The minimum original-code-base change that I see would be:
>>   - "struct position<pos>" is removed in all structures except "struct
>> token" and
>>    replaced with "struct token *<tok>". When<pos>  is needed<tok>->pos is
>>    used instead. This implies that tokens are not freed by default.
>
> No, that would be a no go. I don't mind allow dependence program
> have the option to keep the token around. However, for other C back
> ends, the token serve no purpose. It just sit there waste memory. So
> I don't want the token become mandatory.

If it is a no-go it is a no-go.
If there is no need for the tool i proposed, there is no need. :-)
Still I try: Tokens dont sit around, they are released when
the program finishes. Treating the preprocessing stage
like nonexisting doesnt reflect the way most people use
a compiler. They always use the preprocessor even if
there might be the possibility to use the compiler with only
a preprocessed file. Therefore tokens should sit around.

>
>>   - struct statement *, struct expression *, struct *token
>>    all get a extra "void *custom" pointer. This pointer can be used for
>>    tools to save their own data.
>> I think this is not too far off: 4 bytes more for each struct and
>>   "<tok>->pos"
>> instead of "pos", that is not a massive change. the<tok>->pos would be
>> a boilerplate refactoring.
>
> It is still too invasive. I don't want to keep<tok>->pos in the statements
> and expression.

If this is invasive a little less than this would mean no change at
all.

>
> Instead, how about using the macro_expand I purposed in previous
> email. Make dependence program a two step. The first step is pure
> pre-processing, the dependants program using the macro_expand hook
> to keep track of macro expand details. The end result is the pre-processed
> file and the program remember how the file map into original file using the
> macro expand history.
>
> The the second step is just parsing on the pre-processed file. Using
> the macro expand history to map the position back to the original file.
> In this way, you can do your dependency analyse with minimal
> impact to sparse internals. The macro_expand hook can use to
> do other useful stuff as well. Will that address your need?

Thats not what I want, but rather what you want. If you
want a macro expand history, it would be faster, easier simpler
if you would hack it yourself, I dont want a macro expand,
i have my tool htmltag for that already. I want a macro dependency tree.
With only macro_expand hook and only file-scope <pos> it is not
possible.
And: until I would have come up with something that would fit your requirements
months would be gone. It seems that you know exactly how
it should  be done, there is no way for me to know how
you think a noninvasive solution would look like. The communication
takes too long.

If there is no need for the tool i proposed, there is no need.
At least I tried :-)

-- Thanks Konrad

>
> BTW, have you take a look at the ctags program come with sparse?
> It can find symbols created by macro expansion as well.
>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


From: Konrad Eisele <konrad@gaisler.com>
Subject: Re: Fwd: dependency tee from c parser entities downto token
Date: Tue, 08 May 2012 08:38:53 +0200
Message-ID: <4FA8BF7D.60606@gaisler.com>
References: <4F967865.60809@gaisler.com> <CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com> <CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com> <4FA38635.5060300@gaisler.com> <CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com> <4FA3B14A.3070609@gaisler.com> <CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com> <4FA44E3D.6020504@gmail.com> <CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com> <4FA4EAD6.1040206@gmail.com> <CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com> <CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com> <CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com> <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com> <4FA5B9E8.7010208@
 gmail.com> <CANeU7Qm-M7u0h6MswEMw3KZ7wxaxiikpChXJAuhkV0EzcHkH9A@mail.gmail.com> <4FA767BD.8060703@gaisler.com> <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail176c2.megamailservers.com ([69.49.111.76]:56612 "EHLO
	mail176c2.megamailservers.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753142Ab2EHGtB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 8 May 2012 02:49:01 -0400
In-Reply-To: <CANeU7Q=nHs+f1wKVM0bGDc-uxubBztPxXjiMvDRpph4RJWPHYg@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Konrad Eisele <eiselekd@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

Christopher Li wrote:
> Hi Konrad,
>
> I appreciate all the input. How about this, I am going to implement
> the core sparse
> part of the API change. You will be the first customer that use that
> API. I think this
> API is also useful for people want to do source code transformations
> using sparse.
> They usually want to manipulate the source code stream before the
> pre-processing.
>
> Anyway, I am hacking a branch starting from the last patch I send out.
> I am adding the test program to demonstrate how to use those hooks to accomplish
> different things. You just need to keep telling me what extra feature
> you want from
> the API. I can try to incorporate them with the demo program.

Yea, I think it is better that way. You should implement it yourself first,
it kind of takes too long otherwise :-). Still I'm kind of
curious how you can trace macro expansion with just 1 callback
but I'll like to be surprised.
-- Konrad

>
> I will let you know when I have the branch ready.
>
> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>


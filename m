From: Christopher Li <sparse@chrisli.org>
Subject: Fwd: dependency tee from c parser entities downto token
Date: Sat, 5 May 2012 12:56:10 -0700
Message-ID: <CANeU7QkJJx6A8zfZY9YRJ3GP-msxb3yjQpEO08RbNKE9asPTPA@mail.gmail.com>
References: <4F967865.60809@gaisler.com>
	<CANeU7Qku=Zk3OfY3h45M+ecu11A6eTH0Y0+9wwj9Fmu8TyWwRw@mail.gmail.com>
	<CAEjhO7+EKvFHmpcFHrweGQEa4SHf62AAy5_SyhSxD1bcguafyw@mail.gmail.com>
	<CANeU7QkWbvT-NN5vm=JXnmfDpbzNzTjNYxkB8GJsKCysiOe8tQ@mail.gmail.com>
	<4FA38635.5060300@gaisler.com>
	<CANeU7QnVjEmZC2SNX-arWP7ovRx1mgNRyQSe7N2STGa-5u=i7A@mail.gmail.com>
	<4FA3B14A.3070609@gaisler.com>
	<CANeU7Q=5T2aV2NBwoC5hgtYHaNR1ndELtyy6t-s7C1bNgdTT0A@mail.gmail.com>
	<4FA44E3D.6020504@gmail.com>
	<CANeU7QmzTDarO9xD7NiRsaSasQnVQug6LFCCp9ud0vuBcekS8Q@mail.gmail.com>
	<4FA4EAD6.1040206@gmail.com>
	<CANeU7QnNemo=iyx3+VJBgEzf4kOacxOx9JTsbu5Of46+3NkAJA@mail.gmail.com>
	<CAEjhO7JqWNwGzEYX+xr2gvuCTcnNPovNgk3X1q69E5_CMPnSTw@mail.gmail.com>
	<CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:40291 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab2EET4L (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 5 May 2012 15:56:11 -0400
Received: by yhmm54 with SMTP id m54so3565958yhm.19
        for <linux-sparse@vger.kernel.org>; Sat, 05 May 2012 12:56:10 -0700 (PDT)
In-Reply-To: <CANeU7Qn7vUzLQAF6JGRECro_pPDnL7MCswkrNACe1wohLHZu7g@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>
Cc: Konrad Eisele <eiselekd@gmail.com>

Sorry I forget to CC the list.

Chris


---------- Forwarded message ----------
From: Christopher Li <sparse@chrisli.org>
Date: Sat, May 5, 2012 at 12:54 PM
Subject: Re: dependency tee from c parser entities downto token
To: Konrad Eisele <eiselekd@gmail.com>


On Sat, May 5, 2012 at 9:59 AM, Konrad Eisele <eiselekd@gmail.com> wrote:
>>
>> I am not sure I understand your range representation yet.
>>
>
> You need to view it with a fixed width font. Its not rocket science,
> token lists (or arrays) are viewed as dotted lists. The token.pos
> field is listed below each token as p[x] or as the file-location
> in file-scope.

I am not sure using range is a win because you need to find
the token within a list of ranges. That is a lot of hassle.
Just walk the replacement token in the macro expand hook
and replace them all with new stream and line number seems
easier. The look up is much easier, just an index into the array.

>
> I'll come up with a patch to implement this scheme when I have
> time to and send it, it might take a while.

Can you keep the change to the core sparse library (e.g. adding
hook in parser and pre-processor) as a separate patch? You can
send that part out for review earlier if other part of your dependency
analyse is not ready yet.

Chris

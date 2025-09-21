Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAE7296BA2
	for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758486267; cv=none; b=kUjHwVlJUYVTQiteifziXCkWPN2qpVzNG63v8gt+YBrVDVNP5jcpqlFemkoECKvbcX5VhUKkmwwKCP86gKSqIE9l8zbvJxCWODhPi33yQlScHR3E9mj5Inq9f+hH3OA28hBKjdmH+lzXDFK8qkFZbYJc5SHethFjm19hY/kxHfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758486267; c=relaxed/simple;
	bh=GAoP87MzEykNzgoaa7AXVz2ilQV468zk6o0cZalDD44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCLtfPWqCXyYD2+oP74eOQuThJg4HeCC86PMmVMY1aKEX0MIhafcsvP5ZTWVCBD/EIh+4pG15dLGjv6nsMmzejAkf9amASOiCNGcQgk+sfyT3z+TNxBSHrugHhkx5iuiRR4C2usf3A/OOCitWg1iVHPJGs3nQ1AZHd6OySorwj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org; spf=fail smtp.mailfrom=chrisli.org; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chrisli.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chrisli.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ea5c1e394a8so2620246276.1
        for <linux-sparse@vger.kernel.org>; Sun, 21 Sep 2025 13:24:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758486265; x=1759091065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvV988ie/Onhy/WaSdkT69BC2DYFdZv1ZHxu3DDrlFk=;
        b=U5i8XKIOBWQf3e8AO6PllKQ9TOakHdi7BYnJbH5tbwM+wdH6RJaEt9L2R7xLBP2BFe
         Tsh/Yev8ymzpKT+pew7h2qjGya+FTM1wej8nw4Eun0ktqEds3G198nqFW3KvU6CdzXvV
         5UsiBrto8QkU2Cn+qxzGxSLb1KBXFMN7dUzxY+EYZRhstEUNVIrqfOI9JdblIAY/60qt
         scSGqu0hsIdnlAa18aAfyzWJ5rJpMaNYWdf9X3K1wFazkIVln0ITAh+TkkWOnqFz990l
         Wv0QvLKA8e5nxsPMi0pw0b1BceFeudm0wdsLJ0QJNtmLXrFIKrNal7X5rx081RJVvwe7
         YXgw==
X-Gm-Message-State: AOJu0YykZipleBccfuzpmO67HbTJki1ef2Q15iqyPlnjpIkQF4IdBhQf
	9QfQ8C3xXkX8U8uKx7MjiJlOmxvwneKeGyvUiPP2GrZTR+/as1TQVush7FzHFRuk8uZ0d6fsb0O
	WpSgAxzz8FMEhnx+Bixv5YxV0/Do1Jqna4HuI5KUtzw==
X-Gm-Gg: ASbGncsaUWXP+UzIxdsLeL+po13RwNgJC9eUCZcK+mziPFODsW86HPjurFeoHFh5/tv
	ijtkZlJ23YF+YM4yXrNCL/+uyH/v16sp6MsraJfBKn5b9jlH1X4/SJm2AJeb/ySmaqz7Bd71O6x
	xGwkT0Y8zBTM7nuE2mtBXfy4l0/4EFuSuAsmhbAjUzMjhz7FtGPYsYGokQPnqrB/+oWH+MHtRJF
	xRWfQ==
X-Google-Smtp-Source: AGHT+IEcQh7T7pANc8oUowIFuxsbwZOgWOWdFKNUJTrjTzIRzVl/k+G53JjFPL+ekjzfe2sjsx9zF4y7gk7GJxm2aNo=
X-Received: by 2002:a05:690c:3745:b0:733:2646:cc32 with SMTP id
 00721157ae682-73d3ce7a4b9mr77915367b3.32.1758486264772; Sun, 21 Sep 2025
 13:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-sparse@vger.kernel.org
List-Id: <linux-sparse.vger.kernel.org>
List-Subscribe: <mailto:linux-sparse+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sparse+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com>
 <CAHk-=whCP50Hru1efNTNj23-gMXcbXUEPzt09ivib5JDL5ycVw@mail.gmail.com>
In-Reply-To: <CAHk-=whCP50Hru1efNTNj23-gMXcbXUEPzt09ivib5JDL5ycVw@mail.gmail.com>
From: Chris Li <sparse@chrisli.org>
Date: Sun, 21 Sep 2025 13:24:13 -0700
X-Gm-Features: AS18NWC_KfqSZUErFF2LsZOI2wnTb7n8YWYM8AerJ8umpiuFd7-TFV8RNpsy9nA
Message-ID: <CACePvbU=fAf6nNih5r-epJwU8qpiJ4TmkU6yQg8O1hrJKznDRA@mail.gmail.com>
Subject: Re: Sparse maintainership
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, changyuan.lv@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 11:28=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 18 Sept 2025 at 08:46, Chris Li <sparse@chrisli.org> wrote:
> >
> > I would like to get some clarification on the mailing list:
> > Is the sparse project still maintained? I really don't want to step on
> > anybody's toe.
> >
> > If not, does anyone mind if I slowly resume some maintainer duty at a
> > very very slow pace?
>
> I'd love to have sparse maintained again, I think it's been
> effectively dead for the last two years or so.
>
> I don't think I've seen a commit since February 2024, so I don't think
> there are any feet to step on.

People keep asking if I=E2=80=99m back, and I haven=E2=80=99t really had an=
 answer.
But now, yeah, I=E2=80=99m thinking I=E2=80=99m back.

I just took a look at the sparse repo history since I left. I am very
happy to see Luc did a great job adding a lot of code to sparse.

A learning of mine is that I need to gain the ability to trust other
people's code more, especially from people that I know less about. If
I do it again now, I would just do a simple merge from Luc instead. I
was fiddling with every patch I took, trying to find a better
alternative, if possible at all. Looking back at all the patches Luc
added, it is simply not possible for me to spend that much time on
each patch. The result speaks for itself, the thing I was worried
about the most did not happen at all in sparse anyway. I should have
done a simple merge instead. That is learning and growing on my side.

I want to wholeheartedly thank Luc for taking great care of the sparse
project while I was gone. Before I left, I wasn't motivated to have a
full time job. I was spending more that 50% of my time on sparse and I
am still not able to keep up with Luc's patch series. My leave of
absence in sparse allowed me to engage in some other great adventure
which requires my full dedication. Something I wasn't considering
previously due to the time I spend on sparse. I really have a great
blast, and thank you Luc, for making that possible. I hope there is a
day in the future when Luc comes back to the sparse project, I will be
happy to pull from him, with less fiddling.

Now I am fully employed, with more family duty and cool hobbies, which
include some kernel MM side hustle as well. I will not have the time
to  be the main developer behind sparse. I will take a higher level
manager role for sparse maintenance, delegate more, take patches and
pitching ideas. It will take me a while to catch up with the current
sparse code base and start to apply patches again, please be patient.

I have one observation with the sparse project is that the original
goal of alternative C frontend has been fulfilled by clang. As for
checking, there are many alternatives, e.g. syzbot is stealing the
spotlight. LLVM/clang is the preferred choice for many to do new
compiler experimental hacks. There is just a much bigger community to
find people known to modify the llvm to do different things. The usage
for sparse as a linux kernel specific checker is very niche, a little
bit too niche.

I want to take this opportunity to pivot sparse to something more
relevant to mainstream usage. I want to see better integration of
llvm, through llvm make sparse more of a complete compiler set. I want
to add different flavors in the process. If we are just doing the llvm
backend, why not use llvm instead. I have some daydreaming ideas to
answer the question why we should respect the opportunity of sparse
rather than using llvm instead. I will share more details when my
daydreaming idea gets more concrete.

I received some private emails from different people encouraging me to
come back as well, thank you all for your support.

Chris

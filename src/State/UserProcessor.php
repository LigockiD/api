<?php

namespace App\State;

use ApiPlatform\Metadata\Operation;
use ApiPlatform\State\ProcessorInterface;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;


class UserProcessor implements ProcessorInterface
{


    private EntityManagerInterface $entityManager;
    private UserPasswordHasherInterface $hasher;


    public function __construct(EntityManagerInterface $entityManager, UserPasswordHasherInterface $hasher)
    {
        $this->entityManager = $entityManager;

        $this->hasher = $hasher;
    }

    
    public function process($data, Operation $operation, array $uriVariables = [], array $context = [])
    {
        $hashedPassword = $this->hasher->hashPassword(
            $data,
            $data->getPassword()
        );
        $data->setPassword($hashedPassword);
        $this->entityManager->persist($data);
        $this->entityManager->flush();
        return $data;
    }
}
